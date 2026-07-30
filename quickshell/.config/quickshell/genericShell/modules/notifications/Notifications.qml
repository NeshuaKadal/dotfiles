import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services

Scope {
    id: root
    PanelWindow {
        WlrLayershell.namespace: "quickshell:notification"
        anchors { top: true; right: true }
        margins { top: 10; right: 10 }
        implicitWidth: 380
        implicitHeight: Math.max(1, column.implicitHeight)
        color: "transparent"

        ColumnLayout {
            id: column
            width: parent.width
            spacing: 10

            Repeater {
                model: NotificationService.trackedNotifications
                delegate: Rectangle {
                    id: card
                    required property var modelData

                    Timer {
                        running: card.modelData.urgency != NotificationUrgency.Critical
                        interval: Config.notifications.timeout
                        onTriggered: card.modelData.dismiss()
                    }

                    Layout.fillWidth: true
                    Layout.preferredHeight: cardContent.implicitHeight + 20
                    radius: 20
                    color: ColorUtils.withAlpha(Config.colors.background, Config.opacities.background)
                    border.width: 2
                    border.color: modelData.urgency === NotificationUrgency.Critical ? Config.colors.accent : Config.colors.foreground

                    RowLayout {
			id: cardContent
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Image {
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 36
                            Layout.alignment: Qt.AlignTop
                            fillMode: Image.PreserveAspectFit
                            visible: source.toString() != ""
                            source: card.modelData.image || card.modelData.appIcon || ""
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2
                            Text {
                                Layout.fillWidth: true
                                text: card.modelData.summary
                                color: Config.colors.foreground
                                font.family: Config.fonts.mono
                                font.pixelSize: Config.fonts.size.normal
                                elide: Text.ElideRight
                            }
                            Text {
                                Layout.fillWidth: true
                                visible: text != ""
                                text: card.modelData.body
                                color: Config.colors.foreground
                                font.family: Config.fonts.mono
                                font.pixelSize: Config.fonts.size.small
                                wrapMode: Text.Wrap
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: card.modelData.dismiss()
                    }
                }
            }
        }
    }
}
