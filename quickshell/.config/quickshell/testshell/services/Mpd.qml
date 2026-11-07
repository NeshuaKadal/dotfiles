// services/Mpd.qml
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string artCacheDir: Quickshell.env("HOME") + "/.chace/quickshell/mpd-art"

    property bool connected: false
    property bool playing: false
    property bool random: false
    property bool repeat: false
    property string title: ""
    property string artist: ""
    property string album: ""
    property string file: ""
    property int currentPos: 0
    property string artUrl: ""

    property var queue: []
    property var artists: []
    property var albums: []
    property var songs: []
    property bool _sortSongs: false

    function mpc(...args)   { Quickshell.execDetached(["mpc", ...args]) }
    function toggle()       { mpc("toggle") }
    function next()         { mpc("next") }
    function prev()         { mpc("prev") }
    function shuffle()      { mpc("random") }
    function repeat()       { mpc("repeat") }
    function playPos(pos)   { mpc("play", String(pos)) }
    function removePos(pos) { mpc("del", String(pos)) }
    function clearQueue()   { mpc("clear") }

    Process {
	id: statusProp
	command: ["sh", "-c", "mpc -f '%position%\t%title%\t%artist%\t%file%' current; echo ::status::; mpc status '%state%\t%random%\t%repeat%'"]
	stdout: StdioCollector {
	    onStreamFinished: {
		const idx = text.indexOf("::status::")
                const songLine = (idx < 0 ? text : text.slice(0, idx)).trim()
                const statusLine = idx < 0 ? "" : text.slice(idx + 10).trim()
                const st = statusLine.split("\t")
                root.connected = statusLine !== ""
                root.playing = st[0] === "playing"
		root.random = st[1] === "on"
		root.repeat = st[1] === "on"

                if (songLine) {
                    const f = songLine.split("\t")
                    const file = f[4] ?? ""
                    root.currentPos = parseInt(f[0]) || 0
                    root.title = f[1] || file.split("/").pop()
                    root.artist = f[2] ?? ""
                    root.album = f[3] ?? ""
		    if (file !== root.file) { root.file = file; root.loadArt() }
		}
		else {
                    root.currentPos = 0
		    root.title = ""
		    root.artist = ""
		    root.album = ""
		    root.file = ""
		    root.artUrl = ""
                }
	    }
	}
    }
}
