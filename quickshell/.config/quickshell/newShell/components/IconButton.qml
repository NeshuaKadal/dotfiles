import QtQuick
import qs.config
import qs.services

Item {
    id: root
    property string icon: ""
    property real size: Config.fonts.sizes.normal
    property color iconColor: Colors.m3onSurface
    signal clicked

    implicitWidth: size + 16
    implicitHeight: size + 16

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: ColorUtils.withAlpha(root.iconColor, mouseArea.pressed ? 0.25 : (mouseArea.containsMouse ? 0.12 : 0))

        Behavior on color { ColorAnimation { duration: 100 } }
    }

    Text {
        anchors.centerIn: parent
        text: root.icon
        font.family: Config.fonts.icons.solid
        font.pixelSize: root.size
        color: root.iconColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
