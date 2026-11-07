pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

Singleton {
    id: root

    readonly property string home: Quickshell.env("HOME")

    // XDG user dirs
    readonly property string pictures: Quickshell.env("XDG_PICTURES_DIR") || `${home}/Pictures`
    readonly property string videos: Quickshell.env("XDG_VIDEOS_DIR") || `${home}/Videos`

    // XDG base dirs, namespaced under your app name
    readonly property string data: `${Quickshell.env("XDG_DATA_HOME") || `${home}/.local/share`}/quickshell`
    readonly property string state: `${Quickshell.env("XDG_STATE_HOME") || `${home}/.local/state`}/quickshell`
    readonly property string cache: `${Quickshell.env("XDG_CACHE_HOME") || `${home}/.cache`}/quickshell`
    readonly property string config: `${Quickshell.env("XDG_CONFIG_HOME") || `${home}/.config`}/quickshell`

    // derived
    readonly property string wallpaperState: `${state}/wallpaper`
    readonly property string imagecache: `${cache}/imagecache`
    readonly property string notifimagecache: `${imagecache}/notifs`
    readonly property string wallsdir: Quickshell.env("QS_WALLPAPERS_DIR") || absolutePath(Config.wallpaper.directory)
    readonly property string recsdir: Quickshell.env("QS_RECORDINGS_DIR") || `${videos}/Recordings`

    function absolutePath(path: string): string {
	return path.replace(/~|\$\{?HOME\}?/, root.home)
    }

    function shortenHome(path: string): string {
	return path.replace(root.home, "~")
    }

    Component.onCompleted: {
	mkdirProc.command = [
	    "mkdir", "-p",
	    root.data,
	    root.state,
	    root.cache,
	    root.imagecache,
	    root.notifimagecache,
	    root.wallpaperState
	]
	mkdirProc.running = true
    }

    Process {
	id: mkdirProc
	onExited: (exitCode, exitStatus) => {
	    if (exitCode !== 0) {
		console.warn("Paths: failed to create directories, exit code", exitCode)
	    }
	}
    }
}
