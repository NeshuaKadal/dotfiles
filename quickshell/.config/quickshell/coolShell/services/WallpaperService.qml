pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string current: ""

    FileView {
	id: wallpaperFile
	path: Quickshell.env("HOME") + "/.local/state/quickshell/wallpaper.json"
	watchChanges: false
	onLoaded: {
	    try { root.current = JSON.parse(text()).path ?? ""; }
	    catch (e) { root.current = ""; }
	}
	onLoadFailed: (error) => {}
    }

    function saveWallpaper() {
	wallpaperFile.setText(JSON.stringify({ path: root.current }));
    }

    function setWallpaper(path) {
	root.current = path;
	root.saveWallpaper()

	matugenProc.command = [
	    "matugen", "--config",
	    Quickshell.env("HOME") + "/.config/quickshell/coolShell/matugen/config.toml",
	    "--mode", "dark",
	    "--type", "scheme-vibrant",
	    "--contrast", "1",
	    "--prefer", "saturation",
	    "image", path
	];
	matugenProc.running = true;
    }

    Process { id: matugenProc }
}
