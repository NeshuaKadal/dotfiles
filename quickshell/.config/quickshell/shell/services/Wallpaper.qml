pragma Singleton
import Quickshell
import Quickshell.Io
import qs.config
import qs.utils

Singleton {
    id: root

    readonly property string fallback: Quickshell.shellPath("/assets/fallback.jpeg")

    property string current: ""

    FileView {
        id: wallpaperFile
        path: Paths.wallpaperState + "/current.txt"
        watchChanges: true
        printErrors: false
        onLoaded: {
            let wall = text().trim()
            if (!wall) {
                wall = root.fallback
                root.setWallpaper(wall)
            } else {
                root.current = wall
            }
        }
        onLoadFailed: (error) => {
            root.current = root.fallback
            root.setWallpaper(root.fallback)
        }
        onFileChanged: reload()
    }

    function save() {
        wallpaperFile.setText(root.current)
    }

    function setWallpaper(path: string) {
        if (matugenProc.running) {
            matugenProc.running = false
        }
        root.current = path
        root.save()
        matugenProc.command = [
            "matugen", "--config", Paths.config + "/matugen/config.toml",
            "--mode", "dark",
            "--prefer", "saturation",
            "image", path
        ]
        matugenProc.running = true
    }

    function pickRandom() {
        findProc.running = true
    }

    Process {
        id: findProc
        command: [
            "find", Config.wallpaper.directory,
            "-maxdepth", "1", "-type", "f",
            "(", "-iname", "*.jpg", "-o",
                 "-iname", "*.jpeg", "-o",
                 "-iname", "*.png", ")"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                let files = text.trim().split("\n").filter(f => f.length > 0)
                if (files.length === 0) {
                    console.warn("no wallpapers found in", Config.wallpaper.directory)
                    return
                }
                if (files.length > 1) {
                    files = files.filter(f => f !== root.current)
                }
                const choice = files[Math.floor(Math.random() * files.length)]
                root.setWallpaper(choice)
            }
        }
    }

    Process {
        id: matugenProc
        onExited: (exitCode, exitStatus) => {
            if (exitCode !== 0) {
                console.warn("matugen failed with exit code", exitCode)
            }
        }
    }

    IpcHandler {
        function get(): string {
            return root.current
        }
        function set(path: string): void {
            root.setWallpaper(path)
        }
        target: "wallpaper"
    }
}
