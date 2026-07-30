import QtQuick
import QtQuick.Layouts
import qs.config

Item {
    id: root
    property string text: ""
    property bool outlined: false
    signal clicked

    implicitWidth: label.implicitWidth + 24
    implicitHeight: label.implicitHeight + 16

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 10
        color: root.outlined ? "transparent" : Config.colors.accent
        border.width: root.outlined ? 2 : 0
        border.color: Config.colors.accent
        scale: mouseArea.pressed ? 0.96 : 1.0

        Behavior on scale { NumberAnimation { duration: 100 } }
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: root.text
        font.family: Config.fonts.mono
        font.pixelSize: Config.fonts.size.normal
        color: root.outlined ? Config.colors.accent : Config.colors.background
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
