import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config

PanelWindow {
    id: root
    default property alias content: contentItem.data
    property bool menuShown: false
    property int animDuration: 100

    color: "transparent"
    visible: menuShown

    Item {
        id: surface
        anchors.fill: parent
        opacity: root.menuShown ? 1 : 0
        scale: root.menuShown ? 1 : 0.94

        Behavior on opacity { NumberAnimation { duration: root.animDuration; easing.type: Easing.OutCubic } }
        Behavior on scale { NumberAnimation { duration: root.animDuration; easing.type: Easing.OutCubic } }

        Item {
            id: contentItem
            anchors.fill: parent
        }
    }
}
