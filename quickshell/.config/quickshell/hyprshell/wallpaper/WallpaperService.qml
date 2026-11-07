pragma Singleton
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string dir: Quickshell.env("HOME") + "/Pictures/Wallpapers"
    property var matugenCommand: ["matugen", "-c", Quickshell.env("HOME") + "/.config/quickshell/hyprshell/matugen/config.toml", "--prefer=saturation", "image"]
    property bool applyColors: true
    property string stateFile: Quickshell.env("HOME") + "/.local/state/quickshell/wallpaper"

    property string current: ""

    property string lockImage: ""        // blurred copy; "" until the first one is ready
    property int lockBlur: 16
    property string lockBrightness: "75"
    property string lockCacheDir: Quickshell.env("HOME") + "/.cache/quickshell/lock"
    property string _pendingLock: ""

    readonly property string lockScript: `
	mkdir -p "$(dirname "$2")"
	if [ ! -f "$2" ] || [ "$1" -nt "$2" ]; then
	    magick "$1" -resize '1920x>' -blur "0x$3" -modulate "$4" -quality 90 "$2" || exit 1
	fi
    `

    function hash(s) {
	let h = 5381
	for (let i = 0; i < s.length; i++) h = ((h << 5) + h + s.charCodeAt(i)) | 0
	return (h >>> 0).toString(16)
    }

    function makeLockImage(src) {
	if (!src) return
	_pendingLock = lockCacheDir + "/" + hash(src + "|" + lockBlur + "|" + lockBrightness) + ".jpg"
	lockProc.running = false
	lockProc.command = ["sh", "-c", lockScript, "sh", src, _pendingLock, String(lockBlur), lockBrightness]
	lockProc.running = true
    }

    function resolve(p) {
        if (p.startsWith("~/")) return Quickshell.env("HOME") + p.slice(1)
        if (!p.startsWith("/")) return dir + "/" + p     // bare name = file in the wallpaper dir
        return p
    }

    function list() {
        const out = []
        for (let i = 0; i < files.count; i++) out.push(files.get(i, "filePath"))
        return out
    }

    function setWallpaper(path, applyTheme) {
        if (!path) return
        path = resolve(path)
        current = path
	makeLockImage(path)
        store.setText(path)
        if (applyTheme !== false && applyColors) {
            matugen.running = false
            matugen.command = [...matugenCommand, path]
            matugen.running = true
        }
    }

    function pickRandom() {
        const all = list()
        if (all.length === 0) return
        let pick = all[Math.floor(Math.random() * all.length)]
        if (all.length > 1)
            while (pick === current) pick = all[Math.floor(Math.random() * all.length)]
        setWallpaper(pick)
    }

    function step(delta) {
        const all = list()
        if (all.length === 0) return
        const i = all.indexOf(current)
        setWallpaper(all[((i < 0 ? 0 : i + delta) % all.length + all.length) % all.length])
    }
    function next() { step(1) }
    function prev() { step(-1) }

    FolderListModel {
        id: files
        folder: "file://" + root.dir
        nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.webp"]
        caseSensitive: false
        showDirs: false
        sortField: FolderListModel.Name

        onStatusChanged: if (status === FolderListModel.Ready && root.current === "") root.pickRandom()
    }

    FileView {
        id: store
        path: root.stateFile
        onLoaded: {
            const p = text().trim()
	    if (p) { root.current = p; root.makeLockImage(p) }
        }
    }

    Process {
	id: matugen
	stderr: StdioCollector {
	    onStreamFinished: if (text.trim()) console.warn("[wallpaper] matugen:", text.trim())
	}
	onExited: code => { if (code !== 0) console.warn("[wallpaper] matugen exited with", code) }
    }

    Process {
	id: lockProc
	onExited: code => {
	    if (code === 0) root.lockImage = root._pendingLock
	    else console.warn("[wallpaper] lock blur failed (exit " + code + "); is imagemagick installed?")
	}
    }

    IpcHandler {
        target: "wallpaper"
        function set(path: string): void { root.setWallpaper(path) }
        function random(): void { root.pickRandom() }
        function next(): void { root.next() }
        function prev(): void { root.prev() }
        function get(): string { return root.current }
    }
}
