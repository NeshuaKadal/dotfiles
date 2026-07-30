import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services
import qs.components

MenuWindow {
    id: root
    WlrLayershell.namespace: "quickshell:menu"
    property QsMenuOpener opener

    anchors { top: true; right: true }
    margins { top: 8; right: 8 }
    implicitWidth: 220
    implicitHeight: content.implicitHeight + 20
    exclusiveZone: 0

    Rectangle {
        anchors.fill: parent
        radius: Config.shapes ? Config.shapes.medium : 12
        color: ColorUtils.withAlpha(Config.colors.background, Config.opacities.background)

        ColumnLayout {
            id: content
            anchors.fill: parent
            anchors.margins: 8
            spacing: 2

            Repeater {
                model: root.opener ? root.opener.children : null

                delegate: Item {
                    required property var modelData
                    Layout.fillWidth: true
                    implicitHeight: modelData.isSeparator ? 9 : 32

                    Rectangle {
                        visible: modelData.isSeparator
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        height: 1
                        color: ColorUtils.withAlpha(Config.colors.foreground, 0.15)
                    }

                    Rectangle {
                        visible: !modelData.isSeparator
                        anchors.fill: parent
                        radius: 8
                        color: ColorUtils.withAlpha(
                            Config.colors.foreground,
                            !modelData.enabled ? 0 : (itemMouse.pressed ? 0.16 : (itemMouse.containsMouse ? 0.08 : 0))
                        )
                        Behavior on color { ColorAnimation { duration: 100 } }
                    }

                    RowLayout {
                        visible: !modelData.isSeparator
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        spacing: 8

                        Image {
                            visible: modelData.icon !== ""
                            source: modelData.icon
                            Layout.preferredWidth: 16
                            Layout.preferredHeight: 16
                            sourceSize.width: 16
                            sourceSize.height: 16
                        }
                        Text {
                            text: modelData.text
                            Layout.fillWidth: true
                            color: modelData.enabled ? Config.colors.foreground : ColorUtils.withAlpha(Config.colors.foreground, 0.4)
                            font.family: Config.fonts.mono
                            font.pixelSize: Config.fonts.size.small
                        }
                    }

                    MouseArea {
                        id: itemMouse
                        visible: !modelData.isSeparator
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: modelData.enabled
                        onClicked: {
                            modelData.triggered();
                            root.menuShown = false;
                        }
                    }
                }
            }
        }
    }
}
