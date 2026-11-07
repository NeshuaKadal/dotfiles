import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Pam

Scope {
    id: root

    property string buffer: ""
    property bool busy: false
    property bool failed: false

    onBufferChanged: if (buffer.length > 0) failed = false

    function lock()   { session.locked = true }
    function unlock() { session.locked = false; buffer = ""; busy = false; failed = false }

    function submit() {
        if (busy || buffer === "") return
        busy = true
        failed = false
        if (!pam.start()) busy = false
    }

    GlobalShortcut {
        appid: "quickshell"
        name: "lock"
        onPressed: root.lock()
    }
    IpcHandler {
        target: "lock"
        function lock(): void { root.lock() }
    }

    PamContext {
        id: pam
        configDirectory: "pam"
        config: "password.conf"

        onPamMessage: {
            if (pam.responseRequired) pam.respond(root.buffer)
        }
        onCompleted: result => {
            if (result === PamResult.Success) {
                root.unlock()
            } else {
                root.failed = true
                root.buffer = ""
                root.busy = false
            }
        }
    }

    WlSessionLock {
        id: session
        LockSurface { ctx: root }
    }
}
