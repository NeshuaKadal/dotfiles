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
		text: "Volume"
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

	Text {
	    text: AudioService.sink ? AudioService.displayName(AudioService.sink) : "No output"
	    color: Colors.m3onBackground
	    font.pixelSize: Config.fonts.sizes.small
	    font.family: Config.fonts.mono
	}

	RowLayout {
	    ToggleIconButton {
		checked: AudioService.muted
		iconOn: ""
		iconOff: ""
		onToggled: AudioService.toggleMute()
	    }
	    Slider {
		Layout.fillWidth: true
		value: AudioService.volume
		onMoved: v => AudioService.setVolume(v)
	    }
	}

        Text {
            text: AudioService.source ? AudioService.displayName(AudioService.source) : "No input"
            color: Colors.m3onBackground
            font.pixelSize: Config.fonts.sizes.small
	    font.family: Config.fonts.mono
        }

	RowLayout {
	    ToggleIconButton {
		checked: AudioService.sourceMuted
		iconOn: ""
		iconOff: ""
		onToggled: AudioService.toggleSourceMute()
	    }
	    Slider {
		Layout.fillWidth: true
		value: AudioService.sourceVolume
		onMoved: v => AudioService.setSourceVolume(v)
	    }
	}
    }
}
