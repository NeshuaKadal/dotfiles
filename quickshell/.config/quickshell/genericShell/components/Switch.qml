import QtQuick
import qs.config

Item {
    id: root
    required property bool checked
    signal toggled(bool checked)

    implicitWidth: 40
    implicitHeight: 22

    Rectangle {
        id: track
        anchors.fill: parent
        radius: height / 2
        color: root.checked ? Config.colors.accent : "#50ffffff"
        border.width: root.checked ? 0 : 2
        border.color: Config.colors.foreground

        Behavior on color { ColorAnimation { duration: 150 } }
    }

    Rectangle {
        id: thumb
        width: root.checked ? 16 : 12
        height: width
        radius: width / 2
        anchors.verticalCenter: parent.verticalCenter
        x: root.checked ? parent.width - width - 3 : 3
        color: root.checked ? Config.colors.background : Config.colors.foreground

        Behavior on x { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
        Behavior on width { NumberAnimation { duration: 150 } }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.toggled(!root.checked)
    }
}
