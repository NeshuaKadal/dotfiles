import QtQuick
import QtQuick.Layouts
import qs.config

Item {
    id: root
    property string text: ""
    property string icon: ""
    property color accentColor: Config.colors.accent

    implicitWidth: row.implicitWidth + 20
    implicitHeight: row.implicitHeight + 10

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: ColorUtils.withAlpha(root.accentColor, 0.2)
        border.width: 1
        border.color: root.accentColor
    }

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 4

        Text {
            visible: root.icon !== ""
            text: root.icon
            font.family: Config.icons.solid
            font.pixelSize: Config.fonts.size.small
            color: root.accentColor
        }
        Text {
            text: root.text
            font.family: Config.fonts.mono
            font.pixelSize: Config.fonts.size.small
            color: root.accentColor
        }
    }
}
