import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.services
import qs.config
import qs.components

Item {
    implicitWidth: 360
    implicitHeight: 56

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 11
        anchors.rightMargin: 13
        spacing: 12

        ClippingWrapperRectangle {
            Layout.preferredWidth: parent.implicitHeight
            Layout.preferredHeight: parent.implicitHeight
	    radius: implicitHeight / 2
            clip: true

	    Image {
		anchors.fill: parent
		fillMode: Image.PreserveAspectCrop
		source: PlayerService.artUrl
		visible: source.toString() !== ""
	    }
	}

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            Text {
                Layout.fillWidth: true
                text: PlayerService.title
                color: Colors.m3onBackground
                font.pixelSize: Config.fonts.sizes.normal
                font.family: Config.fonts.mono
                elide: Text.ElideRight
            }
            Text {
                Layout.fillWidth: true
                text: PlayerService.artist
                color: ColorUtils.withAlpha(Colors.m3onBackground, 0.7)
                font.pixelSize: Config.fonts.sizes.small
                font.family: Config.fonts.mono
                elide: Text.ElideRight
            }
        }

	ToggleIconButton {
	    checked: !PlayerService.isPlaying
	    iconOn: ""
	    iconOff: ""
	    onToggled: PlayerService.togglePlay()
	}

    }
}
