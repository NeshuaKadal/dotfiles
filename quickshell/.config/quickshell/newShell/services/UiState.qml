pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string active: ""

    function request(name) {
	root.active = (root.active === name) ? "" : name;
    }

    function close() {
	root.active = "";
    }

    function flash(name, ms) {
	if (root.isMenu(root.active)) return;
	root.active = name;
	osdTimer.target = name;
	osdTimer.interval = ms;
	osdTimer.restart();
    }

    Timer {
        id: osdTimer
        property string target: ""
        onTriggered: {
            if (root.active === target) root.active = "";
        }
    }

    readonly property var menuNames: ["volume", "notifications", "player"]
    function isMenu(name) { return root.menuNames.includes(name); }

    IpcHandler {
	target: "menu"
	function open(name: string): void { root.request(name); }
	function close(): void { root.close(); }
    }
}
