import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.bar.services
import qs.services
import qs.bar.modules

PanelWindow {
    id: root

    anchors { top: true; left: true; right: true }
    implicitHeight: 16
    color: "transparent"
    exclusiveZone: 8

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell: bar"
    WlrLayershell.keyboardFocus: BarState.keyboard ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    Rectangle {
        anchors.fill: parent
        color: Qt.alpha(Colors.mSurface, 0.5)

        Item {
            id: center
            anchors.centerIn: parent
            height: parent.height
            width: loader.item ? loader.item.implicitWidth : 0
            clip: true
            Behavior on width { NumberAnimation { duration: 120; easing.type: Easing.OutCubic } }

            Loader {
                id: loader
                anchors.centerIn: parent
                sourceComponent: Modules.viewFor(BarState.mode)
            }
        }
    }
}
