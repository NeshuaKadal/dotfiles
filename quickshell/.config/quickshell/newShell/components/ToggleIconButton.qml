import QtQuick
import qs.config
import qs.services

Item {
    id: root
    required property bool checked
    property string iconOn: ""
    property string iconOff: ""
    property real size: Config.fonts.sizes.medium
    property color activeColor: Colors.m3primary
    property color inactiveColor: Colors.m3onBackground
    signal toggled(bool checked)

    implicitWidth: size + 16
    implicitHeight: size + 16

    readonly property color currentColor: root.checked ? root.activeColor : root.inactiveColor

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: ColorUtils.withAlpha(root.currentColor, mouseArea.pressed ? 0.3 : (mouseArea.containsMouse ? 0.15 : (root.checked ? 0.12 : 0)))

        Behavior on color { ColorAnimation { duration: 100 } }
    }

    Text {
        anchors.centerIn: parent
        text: root.checked ? root.iconOn : root.iconOff
        font.family: Config.fonts.icons.solid
        font.pixelSize: root.size
        color: root.currentColor

        Behavior on color { ColorAnimation { duration: 100 } }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.toggled(!root.checked)
    }
}
