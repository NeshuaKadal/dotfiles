// modules/panel/PanelState.qml
pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Singleton {
    id: root

    property bool visible: false
    property var screen: null
    property int current: 0

    function toggle(): void {
        if (visible) {
            visible = false
            return
        }

        const monitor = Hyprland.focusedMonitor
        const name = monitor ? monitor.name : ""
        screen = Quickshell.screens.find(s => s.name === name) ?? Quickshell.screens[0]
        visible = true
    }

    function goto(index: int): void {
	current = Math.max(0, Math.min(index, Screens.list.length - 1))
    }

    function next(): void {
	current = (current + 1) % Screens.list.length
    }

    function prev(): void {
	current = (current - 1 + Screens.list.length) % Screens.list.length
    }

    IpcHandler {
        target: "panel"

        function toggle(): void {
            root.toggle()
	}

	function next(): void {
	    root.next()
	}

	function prev(): void {
	    root.prev()
	}

	function goto(index: int): void {
	    root.goto(index)
	}
    }
}
