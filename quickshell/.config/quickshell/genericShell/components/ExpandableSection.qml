import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services

ColumnLayout {
    id: root
    default property alias content: contentColumn.children
    property string title: ""
    property string currentValue: ""
    property bool expanded: false

    Layout.fillWidth: true
    spacing: 6

    RowLayout {
        Layout.fillWidth: true
        Layout.topMargin: 10

        Text {
            text: root.title
            color: Config.colors.foreground
            font.pixelSize: Config.fonts.size.normal
            font.family: Config.fonts.mono
            Layout.fillWidth: true
        }
        Text {
            text: root.currentValue
            color: ColorUtils.withAlpha(Config.colors.foreground, Config.opacities.muted)
            font.pixelSize: Config.fonts.size.small
            font.family: Config.fonts.mono
            elide: Text.ElideRight
            Layout.maximumWidth: 140
        }

        Item {
            implicitWidth: chevron.implicitWidth + 16
            implicitHeight: chevron.implicitHeight + 16

            Text {
                id: chevron
                anchors.centerIn: parent
                text: ""
                font.family: Config.icons.solid
                font.pixelSize: Config.fonts.size.small
                color: ColorUtils.withAlpha(Config.colors.foreground, Config.opacities.muted)
                rotation: root.expanded ? 180 : 0

                Behavior on rotation { NumberAnimation { duration: 50 } }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.expanded = !root.expanded
            }
        }
    }

    ColumnLayout {
        id: contentColumn
        Layout.fillWidth: true
        spacing: 6
        Layout.preferredHeight: root.expanded ? implicitHeight : 0
        clip: true

        Behavior on Layout.preferredHeight { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
    }
}
