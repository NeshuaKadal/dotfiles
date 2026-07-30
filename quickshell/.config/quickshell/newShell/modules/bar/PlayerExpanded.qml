import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.services
import qs.config
import qs.components

Item {
    implicitWidth: 460
    implicitHeight: content.implicitHeight + 32

    ColumnLayout {
	id: content
	anchors.fill: parent
	anchors.margins: 16
	spacing: 14

	RowLayout  {
	    Layout.fillWidth: true
	    spacing: 14

	    ClippingWrapperRectangle {
		Layout.preferredWidth: 144
		Layout.preferredHeight: 144
		radius: 72
		color: ColorUtils.withAlpha(Colors.m3onBackground, 0.1)

		IconImage {
		    id: artImage
		    anchors.fill: parent
		    source: PlayerService.artUrl
		    visible: source.toString() !== ""

		    readonly property real spinsPerTrack: 10   // how many full rotations across one full song
		    rotation: PlayerService.length > 0 ? (PlayerService.position / PlayerService.length) * 360 * spinsPerTrack : 0

		    Behavior on rotation {
			enabled: !PlayerService.seeking && PlayerService.isPlaying
			NumberAnimation { duration: 1000; easing.type: Easing.Linear }
		    }
		}
	    }

	    ColumnLayout {
		Layout.fillWidth: true
		spacing: 4

		RowLayout {
		    ColumnLayout {
			Text {
			    Layout.fillWidth: true
			    text: PlayerService.title
			    color: Colors.m3onBackground
			    font.pixelSize: Config.fonts.sizes.normal
			    elide: Text.ElideRight
			}
			Text {
			    Layout.fillWidth: true
			    text: PlayerService.artist
			    color: Colors.m3outline
			    font.pixelSize: Config.fonts.sizes.small
			    elide: Text.ElideRight
			}
		    }
		    ColumnLayout {
			IconButton {
			    icon: ""
			    onClicked: UiState.close()
			}
			Item { Layout.fillHeight: true }
		    }
		}

		Slider {
		    Layout.fillWidth: true
		    value: PlayerService.length > 0 ? PlayerService.position / PlayerService.length : 0
		    onMoved: v => {
			PlayerService.seeking = true;
			PlayerService.position = v * PlayerService.length;
		    }
		    onReleased: v => {
			PlayerService.seek(v * PlayerService.length);
			PlayerService.seeking = false;
		    }
		}

		RowLayout {
		    Layout.fillWidth: true
		    Text {
			text: PlayerService.formatTime(PlayerService.position)
			color: Colors.m3outline
			font.pixelSize: Config.fonts.sizes.tiny
		    }
		    Item { Layout.fillWidth: true }
		    Text {
			text: "-" + PlayerService.formatTime(Math.max(0, PlayerService.length - PlayerService.position))
			color: Colors.m3outline
			font.pixelSize: Config.fonts.sizes.tiny
		    }
		}

		RowLayout {
		    Layout.alignment: Qt.AlignHCenter
		    spacing: 30

		    ToggleIconButton {
			checked: PlayerService.shuffle
			iconOn: ""
			iconOff: ""
			visible: PlayerService.shuffleSupported
			size: Config.fonts.sizes.small
			onToggled: PlayerService.toggleShuffle()
		    }

		    IconButton {
			icon: ""
			size: Config.fonts.sizes.large
			onClicked: PlayerService.previous()
		    }
		    ToggleIconButton {
			checked: !PlayerService.isPlaying
			iconOn: ""
			iconOff: ""
			size: Config.fonts.sizes.medium
			onToggled: PlayerService.togglePlay()
		    }
		    IconButton {
			icon: ""
			size: Config.fonts.sizes.medium
			onClicked: PlayerService.next()
		    }
		    ToggleIconButton {
			checked: PlayerService.loopState === 2
			iconOn: ""
			iconOff: ""
			visible: PlayerService.loopSupported
			size: Config.fonts.sizes.small
			onToggled: PlayerService.toggleRepeat()
		    }
		}
	    }
	}
    }
}
