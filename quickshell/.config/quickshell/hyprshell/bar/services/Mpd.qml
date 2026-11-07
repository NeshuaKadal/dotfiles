pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string artCacheDir: Quickshell.env("HOME") + "/.cache/quickshell/mpd-art"

    // --- now playing ---
    property bool connected: false
    property bool playing: false
    property bool random: false
    property string title: ""
    property string artist: ""
    property string album: ""
    property string file: ""
    property int currentPos: 0          // 1-based queue position, 0 = none
    property string artUrl: ""

    // --- lists ---
    property var queue: []              // [{ pos, title, artist, file }]
    property var artists: []
    property var albums: []
    property var songs: []              // [{ track, title, file }]
    property bool _sortSongs: false

    // --- transport ---
    function mpc(...args) { Quickshell.execDetached(["mpc", ...args]) }
    function toggle()  { mpc("toggle") }
    function next()    { mpc("next") }
    function prev()    { mpc("prev") }
    function shuffle() { mpc("random") }                 // toggles random mode
    function playPos(pos)   { mpc("play", String(pos)) }
    function removePos(pos) { mpc("del", String(pos)) }
    function clearQueue() { mpc("clear") }

    // --- adding music ---
    // criteria like ["artist", "X", "album", "Y"]; replace = clear the queue and play
    function addMatch(criteria, replace) {
        const cmd = (replace ? "mpc clear >/dev/null && " : "")
                  + 'mpc findadd "$@" >/dev/null'
                  + (replace ? " && mpc play >/dev/null" : "")
        Quickshell.execDetached(["sh", "-c", cmd, "sh", ...criteria])
    }
    function addFile(file, replace) {
        const cmd = (replace ? "mpc clear >/dev/null && " : "")
                  + 'mpc add "$1" >/dev/null'
                  + (replace ? " && mpc play >/dev/null" : "")
        Quickshell.execDetached(["sh", "-c", cmd, "sh", file])
    }

    // --- library queries ---
    function run(proc, cmd) { proc.running = false; proc.command = cmd; proc.running = true }
    function loadArtists() { run(artistsProc, ["mpc", "list", "artist"]) }
    function loadAlbums(artist) { run(albumsProc, ["mpc", "list", "album", "artist", artist]) }
    function loadSongs(artist, album) {
        const args = ["mpc", "-f", "%track%\t%title%\t%file%", "find", "artist", artist]
        if (album) args.push("album", album)
        _sortSongs = !!album
        run(songsProc, args)
    }

    Process {
        id: artistsProc
        stdout: StdioCollector { onStreamFinished: root.artists = text.split("\n").filter(s => s) }
    }
    Process {
        id: albumsProc
        stdout: StdioCollector { onStreamFinished: root.albums = text.split("\n").filter(s => s) }
    }
    Process {
        id: songsProc
        stdout: StdioCollector {
            onStreamFinished: {
                const rows = text.split("\n").filter(s => s).map(l => {
                    const f = l.split("\t")
                    const file = f[2] ?? ""
                    return { track: parseInt(f[0]) || 0, title: f[1] || file.split("/").pop(), file: file }
                }).filter(r => r.file)
                if (root._sortSongs) rows.sort((a, b) => a.track - b.track)
                root.songs = rows
            }
        }
    }

    // --- status ---
    function refresh() { statusProc.running = false; statusProc.running = true }
    function refreshQueue() { queueProc.running = false; queueProc.running = true }

    Process {
        id: statusProc
        command: ["sh", "-c",
            "mpc -f '%position%\t%title%\t%artist%\t%album%\t%file%' current; echo ::status::; mpc status '%state%\t%random%'"]
        stdout: StdioCollector {
            onStreamFinished: {
                const idx = text.indexOf("::status::")
                const songLine = (idx < 0 ? text : text.slice(0, idx)).trim()
                const statusLine = idx < 0 ? "" : text.slice(idx + 10).trim()
                const st = statusLine.split("\t")
                root.connected = statusLine !== ""
                root.playing = st[0] === "playing"
                root.random = st[1] === "on"

                if (songLine) {
                    const f = songLine.split("\t")
                    const file = f[4] ?? ""
                    root.currentPos = parseInt(f[0]) || 0
                    root.title = f[1] || file.split("/").pop()
                    root.artist = f[2] ?? ""
                    root.album = f[3] ?? ""
                    if (file !== root.file) { root.file = file; root.loadArt() }
                } else {
                    root.currentPos = 0
                    root.title = ""; root.artist = ""; root.album = ""
                    root.file = ""; root.artUrl = ""
                }
            }
        }
    }

    Process {
        id: queueProc
        command: ["mpc", "-f", "%position%\t%title%\t%artist%\t%file%", "playlist"]
        stdout: StdioCollector {
            onStreamFinished: root.queue = text.split("\n").filter(s => s).map(l => {
                const f = l.split("\t")
                const file = f[3] ?? ""
                return { pos: parseInt(f[0]) || 0, title: f[1] || file.split("/").pop(),
                         artist: f[2] ?? "", file: file }
            })
        }
    }

    // --- album art: embedded picture first, then cover file in the album folder ---
    readonly property string artScript: `
        d="$2"; mkdir -p "$d"
        out="$d/$(printf '%s' "$(dirname -- "$1")" | md5sum | cut -c1-16)"
        if [ ! -s "$out" ]; then
            mpc readpicture "$1" > "$out" 2>/dev/null
            [ -s "$out" ] || mpc albumart "$1" > "$out" 2>/dev/null
        fi
        if [ -s "$out" ]; then printf '%s' "$out"; else rm -f "$out"; fi
    `
    function loadArt() {
        artProc.running = false
        artUrl = ""
        if (!file) return
        artProc.command = ["sh", "-c", artScript, "sh", file, artCacheDir]
        artProc.running = true
    }
    Process {
        id: artProc
        stdout: StdioCollector {
            onStreamFinished: root.artUrl = text.trim() ? "file://" + text.trim() : ""
        }
    }

    // --- event loop: wakes only when MPD changes ---
    Process {
        id: idle
        running: true
        command: ["mpc", "idleloop", "player", "playlist", "options"]
        stdout: SplitParser {
            onRead: line => {
                if (line === "playlist") root.refreshQueue()
                root.refresh()
            }
        }
        onExited: retry.start()          // MPD not running yet: keep trying
    }
    Timer {
        id: retry
        interval: 3000
        onTriggered: { idle.running = true; root.refresh(); root.refreshQueue() }
    }

    Component.onCompleted: { refresh(); refreshQueue() }
}
