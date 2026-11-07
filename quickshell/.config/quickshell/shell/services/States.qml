pragma Singleton
import Quickshell

Singleton {
    id: root

    property bool launcherOpen: false
    property bool powerMenuOpen: false
    property bool notificationCenterOpen: false
    property bool wallpaperPickerOpen: false
    property bool settingsOpen: false

    readonly property bool anyOpen: launcherOpen || powerMenuOpen || notificationCenterOpen || wallpaperPickerOpen || settingsOpen

    function open(name) {
        closeAll()
        if (root.hasOwnProperty(name + "Open")) {
            root[name + "Open"] = true
        }
    }

    function close(name) {
        if (root.hasOwnProperty(name + "Open")) {
            root[name + "Open"] = false
        }
    }

    function toggle(name) {
        if (root[name + "Open"]) {
            close(name)
        } else {
            open(name)
        }
    }

    function closeAll() {
        launcherOpen = false
        powerMenuOpen = false
        notificationCenterOpen = false
        wallpaperPickerOpen = false
        settingsOpen = false
    }
}
