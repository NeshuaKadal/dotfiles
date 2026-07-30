import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

Item {
    implicitWidth: 360
    implicitHeight: 40

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 4
        anchors.rightMargin: 16
        spacing: 2

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
}
