import QtQuick
import qs.config

Rectangle {
    id: root
    required property bool checked

    implicitWidth: 16
    implicitHeight: 16
    radius: width / 2
    color: "transparent"
    border.width: 2
    border.color: checked ? Config.colors.accent : Config.colors.foreground

    Behavior on border.color { ColorAnimation { duration: 120 } }

    Rectangle {
        anchors.centerIn: parent
        width: parent.width * 0.5
        height: width
        radius: width / 2
        color: Config.colors.accent
        opacity: root.checked ? 1 : 0
        scale: root.checked ? 1 : 0.5

        Behavior on opacity { NumberAnimation { duration: 120 } }
        Behavior on scale { NumberAnimation { duration: 120; easing.type: Easing.OutBack } }
    }
}
