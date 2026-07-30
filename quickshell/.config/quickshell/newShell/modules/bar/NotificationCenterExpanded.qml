import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.components

Item {
    implicitWidth: 360
    implicitHeight: content.implicitHeight + 32

    ColumnLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: "Notifications"
                color: Colors.m3onBackground
                font.pixelSize: Config.fonts.sizes.medium
                font.family: Config.fonts.mono
                Layout.fillWidth: true
            }
	    IconButton {
		icon: ""
		onClicked: UiState.close()
	    }
        }

        Flickable {
	    id: notifFlickable
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(280, list.implicitHeight)
            contentHeight: list.implicitHeight
	    clip: true

	    maximumFlickVelocity: 800

            ColumnLayout {
                id: list
                width: parent.width
                spacing: 6

		Repeater {
		    model: NotificationService.history
		    delegate: Rectangle {
			id: card
			required property var modelData
			required property int index

			Layout.fillWidth: true
			Layout.preferredHeight: cardContent.implicitHeight + 20
			radius: 16
			color: Colors.m3surfaceVariant

			ColumnLayout {
			    id: cardContent
			    anchors.fill: parent
			    anchors.margins: 10
			    spacing: 2

			    RowLayout {
				Layout.fillWidth: true
				Text {
				    Layout.fillWidth: true
				    text: modelData.summary
				    color: Colors.m3onSurfaceVariant
				    font.family: Config.fonts.mono
				    elide: Text.ElideRight
				}
				IconButton {
				    icon: ""
				    size: Config.fonts.sizes.small
				    onClicked: NotificationService.removeAt(index)
				}
			    }
			    Text {
				Layout.fillWidth: true
				visible: text !== ""
				text: modelData.body
				color: Colors.m3onBackground
				font.pixelSize: Config.fonts.sizes.tiny
				font.family: Config.fonts.mono
				wrapMode: Text.Wrap
			    }
			}
		    }
		}
	    }
	}
	RowLayout {
	    Layout.fillWidth: true
	    Button {
		text: "Clear All"
		size: Config.fonts.sizes.normal
		onClicked: NotificationService.clearHistory()
	    }
	    Item { Layout.fillWidth: true }
	    ToggleIconButton {
		checked: NotificationService.doNotDisturb
		iconOn: ""
		iconOff: ""
		size: Config.fonts.sizes.normal
		onToggled: NotificationService.toggleDnd()
	    }
	}
    }
}
