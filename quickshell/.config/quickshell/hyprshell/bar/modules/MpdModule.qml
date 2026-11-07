import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.bar.components
import qs.bar.services

BarModule {
    id: mod
    name: "mpd"

    property string page: "now"        // "now" | "queue" | "browse"

    function open() { page = "now"; BarState.toggle("mpd", true) }

    GlobalShortcut {
        appid: "quickshell"
        name: "mpd"
        onPressed: mod.open()
    }
    IpcHandler {
        target: "mpd"
        function toggle(): void { mod.open() }
    }

    // warm the singleton so the first open isn't empty
    Component.onCompleted: Mpd.refresh()

    view: Component {
        Loader {
            sourceComponent: mod.page === "queue" ? queueC
                           : mod.page === "browse" ? browseC : nowC

            Component { id: nowC;    MpdNowPage    { onNavigate: to => mod.page = to } }
            Component { id: queueC;  MpdQueuePage  { onNavigate: to => mod.page = to } }
            Component { id: browseC; MpdBrowsePage { onNavigate: to => mod.page = to } }
        }
    }
}
