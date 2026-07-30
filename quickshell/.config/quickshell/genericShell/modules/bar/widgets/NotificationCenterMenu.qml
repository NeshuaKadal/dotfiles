import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import qs.config
import qs.services
import qs.components

MenuWindow {
    id: root
    WlrLayershell.namespace: "quickshell:menu"
    menuShown: false
    anchors { top: true; right: true }
    margins { top: 8; right: 8 }
    implicitWidth: 380
    implicitHeight: Math.min(500, content.implicitHeight + 20)
    exclusiveZone: 0

    Rectangle {
        anchors.fill: parent
        radius: 16
        color: ColorUtils.withAlpha(Config.colors.background, Config.opacities.background)

        ColumnLayout {
            id: content
            anchors.fill: parent
            anchors.margins: 15
            spacing: 10

	    RowLayout {
		Layout.fillWidth: true
		Text {
		    text: "Notifications"
		    color: Config.colors.foreground
		    font.family: Config.fonts.mono
		    font.pixelSize: Config.fonts.size.medium
		    Layout.fillWidth: true
		}

		ToggleIconButton {
		    checked: NotificationService.doNotDisturb
		    iconOn: ""
		    iconOff: ""
		    onToggled: NotificationService.toggleDnd()
		}
		IconButton {
		    icon: ""
		    onClicked: root.menuShown = false
		}
	    }

	    Button {
		text: "Clear All"
		outlined: true
		onClicked: NotificationService.clearHistory()
	    }

	    Flickable {
		Layout.fillWidth: true
		Layout.preferredHeight: Math.min(300, list.implicitHeight)
		contentHeight: list.implicitHeight
		clip: true

                ColumnLayout {
                    id: list
                    width: parent.width
                    spacing: 6

                    Repeater {
                        model: NotificationService.history
			delegate: ColumnLayout {
			    required property var modelData
			    required property int index
			    Layout.fillWidth: true
			    spacing: 10

			    Rectangle {
				Layout.fillWidth: true
				Layout.preferredHeight: cardContent.implicitHeight + 20
				radius: 20
				color: "transparent"
				border.width: 2
				border.color: modelData.urgency === NotificationUrgency.Critical ? Config.colors.accent : ColorUtils.withAlpha(Config.colors.foreground, Config.opacities.muted)

				ColumnLayout {
				    id: cardContent
				    anchors.fill: parent
				    anchors.margins: 10
				    spacing: 4

				    RowLayout {
					Layout.fillWidth: true
					spacing: 10

					Text {
					    Layout.fillWidth: true
					    text: modelData.summary
					    color: Config.colors.foreground
					    font.family: Config.fonts.mono
					    font.pixelSize: Config.fonts.size.normal
					    elide: Text.ElideRight
					}
					Text {
					    text: new Date(modelData.time).toLocaleTimeString(Qt.locale(), "h:mm")
					    color: ColorUtils.withAlpha(Config.colors.foreground, Config.opacities.muted)
					    font.family: Config.fonts.mono
					    font.pixelSize: Config.fonts.size.small
					}
					IconButton {
					    icon: ""
					    onClicked: NotificationService.removeAt(index)
					}

				    }

				    Text {
					Layout.fillWidth: true
					visible: text != ""
					text: modelData.body
					color: Config.colors.foreground
					font.family: Config.fonts.mono
					font.pixelSize: Config.fonts.size.small
					wrapMode: Text.Wrap
				    }

				    Text {
					visible: text != ""
					text: modelData.appName
					color: ColorUtils.withAlpha(Config.colors.foreground, Config.opacities.muted)
					font.family: Config.fonts.mono
					font.pixelSize: Config.fonts.size.tiny
				    }
				}
			    }
			}
		    }
		}
	    }
	}
    }
}
