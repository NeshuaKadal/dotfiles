import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.components

Item {
    id: root
    required property string output

    implicitWidth: Math.max(360, row.implicitWidth + 16)
    implicitHeight: 40

    RowLayout {
	id: row
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 6

	Workspaces { output: root.output; }

	Item { Layout.fillWidth: true }

	Clock {}

	Item { Layout.fillWidth: true }

	IconButton {
	    icon: AudioService.muted ? "" : ""
	    iconColor: AudioService.muted ? Colors.m3primary : Colors.m3onSurface
	    onClicked: UiState.request("volume")
	}

	IconButton {
	    icon: NotificationService.doNotDisturb ? "" : ""
	    iconColor: NotificationService.history.length > 0 ? Colors.m3primary : Colors.m3onSurface
	    onClicked: UiState.request("notifications")
	}
	IconButton {
	    icon: ""
	    iconColor: PlayerService.isPlaying ? Colors.m3primary : Colors.m3onSurface
	    onClicked: UiState.request("player")
	}
	IconButton {
	    icon: ""
	    iconColor: Colors.m3onSurface
	    onClicked: UiState.request("wallpaper")
	}
    }
}
