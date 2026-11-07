pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    property string mode: "default"
    property bool keyboard: false

    function open(name, wantsKeyboard) {
        revert.stop()
        keyboard = !!wantsKeyboard
        mode = name
    }
    function close() {
        revert.stop()
        keyboard = false
        mode = "clock"
    }
    function toggle(name, wantsKeyboard) {
        if (mode === name) close()
        else open(name, wantsKeyboard)
    }

    Timer { id: revert; onTriggered: root.mode = "default" }
    Timer { id: boot; interval: 1000; running: true }
}
