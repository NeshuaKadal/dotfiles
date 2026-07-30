import QtQuick
import qs.config

Item {
    id: root
    required property Item target
    property string text: ""

    property bool _hovered: false

    Connections {
        target: root.target
        function onHoveredChanged() { root._hovered = root.target.hovered; }
    }

    Rectangle {
        visible: root._hovered && root.text !== ""
        opacity: root._hovered ? 1 : 0
        radius: 6
        color: Config.colors.background
        border.width: 1
        border.color: Config.colors.foreground
        implicitWidth: label.implicitWidth + 16
        implicitHeight: label.implicitHeight + 8

        x: root.target ? root.target.x + (root.target.width - width) / 2 : 0
        y: root.target ? root.target.y + root.target.height + 4 : 0

        Behavior on opacity { NumberAnimation { duration: 100 } }

        Text {
            id: label
            anchors.centerIn: parent
            text: root.text
            font.family: Config.fonts.mono
            font.pixelSize: Config.fonts.size.tiny
            color: Config.colors.foreground
        }
    }
}
