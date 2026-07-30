import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.components

Item {
    id: root
    required property string label
    required property bool selected
    signal activated

    Layout.fillWidth: true
    implicitHeight: 32

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: ColorUtils.withAlpha(root.selected ? Colors.m3primary : Colors.m3onBackground,mouseArea.pressed ? 0.16 : (mouseArea.containsMouse ? 0.08 : 0))
        Behavior on color { ColorAnimation { duration: 100 } }
    }

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 8
        spacing: 8

        RadioButton {
            checked: root.selected
        }

        Text {
            id: labelText
            text: root.label
            color: root.selected ? Colors.m3primary : Colors.m3onSurface
            font.pixelSize: Config.fonts.sizes.normal
            font.family: Config.fonts.mono
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.activated()
    }
}
