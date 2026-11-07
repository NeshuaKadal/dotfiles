pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    property string mode: "clock"
    property bool sticky: false      // true = stays until close() (menu, launcher)
    property bool keyboard: false    // true = bar grabs keyboard (launcher)

    function flash(name, ms) {
        if (sticky || boot.running) return
        mode = name
        revert.interval = ms || 1000
        revert.restart()
    }
    function open(name, wantsKeyboard) {
        revert.stop()
        sticky = true
        keyboard = !!wantsKeyboard
        mode = name
    }
    function close() {
        revert.stop()
        sticky = false
        keyboard = false
        mode = "clock"
    }
    function toggle(name, wantsKeyboard) {
        if (sticky && mode === name) close()
        else open(name, wantsKeyboard)
    }

    Timer { id: revert; onTriggered: root.mode = "clock" }
    Timer { id: boot; interval: 1000; running: true }   // ignore startup signals
}
