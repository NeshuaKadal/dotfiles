import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services

Item {
    id: root
    property string text: ""
    property bool outlined: false
    property color buttonColor: Colors.m3primary
    property int size: Config.fonts.sizes.normal
    signal clicked

    implicitWidth: label.implicitWidth + 24
    implicitHeight: size + 16

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: root.implicitHeight / 2
        color: root.outlined ? "transparent" : buttonColor
        border.width: root.outlined ? 2 : 0
        border.color: buttonColor
        scale: mouseArea.pressed ? 0.96 : 1.0

        Behavior on scale { NumberAnimation { duration: 100 } }
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: root.text
        font.family: Config.fonts.mono
        font.pixelSize: root.size
        color: root.outlined ? buttonColor : Colors.m3surface
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
