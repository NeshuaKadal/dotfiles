import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.bar.components
import qs.bar.services

BarModule {
    id: mod
    name: "power"

    function exec(cmd) { BarState.close(); Quickshell.execDetached(cmd) }

    property var actions: [
        { text: "LOCK", run: () => mod.exec(["qs", "-c", "hyprshell", "ipc", "call", "lock", "lock"]) },
        { text: "SUSPEND", run: () => mod.exec(["systemctl", "suspend"]) },
        { text: "LOGOUT", run: () => mod.exec(["hyprctl", "dispatch", "hl.dsp.exit()"]) },
        { text: "REBOOT", run: () => mod.exec(["systemctl", "reboot"]) },
        { text: "POWEROFF", run: () => mod.exec(["systemctl", "poweroff"]) }
    ]

    GlobalShortcut {
        appid: "quickshell"
        name: "power"
        onPressed: BarState.toggle("power", true)
    }

    view: Component {
        Row {
            focus: true
            Component.onCompleted: forceActiveFocus()

            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape) {
                    BarState.close()
                    event.accepted = true
                    return
                }
                const n = event.key - Qt.Key_1
                if (n >= 0 && n < mod.actions.length) {
                    mod.actions[n].run()
                    event.accepted = true
                }
            }

            Repeater {
                model: mod.actions

                BarButton {
                    required property var modelData
                    required property int index
                    onClicked: modelData.run()

                    Row {
                        spacing: 4
                        BarText {
			    text: index + 1
			    font.pixelSize: 8
                        }
                        BarText {
                            text: modelData.text
                        }
                    }
                }
            }
        }
    }
}
