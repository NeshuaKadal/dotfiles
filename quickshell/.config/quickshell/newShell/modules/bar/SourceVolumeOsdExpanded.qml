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
