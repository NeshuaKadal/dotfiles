import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.bar.components
import qs.bar.services

BarModule {
    id: mod
    name: "workspaces"

    // always shown, even when empty
    property var persistent: [1, 2, 3, 4, 5, 6, 7, 8, 9]

    // persistent ones + any other workspace that currently exists, sorted
    readonly property var shown: {
        const ids = new Set(persistent)
        for (const ws of Array.from(Hyprland.workspaces.values))
            if (ws.id > 0) ids.add(ws.id)          // skip special workspaces
        return Array.from(ids).sort((a, b) => a - b)
    }

    function exists(id) {
        return Array.from(Hyprland.workspaces.values).some(ws => ws.id === id)
    }

    view: Component {
        Row {
            Repeater {
                model: mod.shown

                Rectangle {
                    id: ws
                    required property int modelData
                    readonly property bool selected: Hyprland.focusedWorkspace?.id === modelData
                    readonly property bool occupied: mod.exists(modelData)

                    implicitWidth: Math.max(label.implicitWidth + 8, 16)
                    implicitHeight: 16
                    color: selected ? Qt.rgba(222/255, 222/255, 222/255, 1) : Qt.rgba(1, 1, 1, ma.pressed ? 0.10 : ma.containsMouse ? 0.15 : 0)
                    Behavior on color { ColorAnimation { duration: 80 } }

                    BarText {
                        id: label
                        anchors.centerIn: parent
                        text: ws.modelData
                        opacity: ws.selected || ws.occupied ? 1 : 0.4
                        color: ws.selected ? Qt.rgba(14/255, 14/255, 14/255, 1) : Qt.rgba(222/255, 222/255, 222/255, 1)
                    }

                    MouseArea {
                        id: ma
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Quickshell.execDetached(["hyprctl", "dispatch", "hl.dsp.focus({ workspace = " + ws.modelData + " })"])
                    }
                }
            }
        }
    }

    Connections {
        target: Hyprland
        function onFocusedWorkspaceChanged() { BarState.flash("workspaces") }
    }
}
