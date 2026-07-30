import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components

Scope {
    id: root
    property bool shouldShowOsd: false

    Connections {
        target: AudioService
        function onVolumeChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
        function onMutedChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
    }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    LazyLoader {
	active: root.shouldShowOsd
	PanelWindow {
	    WlrLayershell.namespace: "quickshell:osd"
	    anchors.top: true
	    margins.top: screen.height * 0.01
	    exclusiveZone: 0
	    implicitWidth: 400
	    implicitHeight: 30
	    color: "transparent"
	    mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: 20
                color: ColorUtils.withAlpha(Config.colors.background, Config.opacities.background)

                RowLayout {
                    anchors { fill: parent; leftMargin: 10; rightMargin: 20 }
                    spacing: 10

                    Text {
                        text: AudioService.muted ? "" : ""
                        font.pixelSize: Config.fonts.size.icon
                        font.family: Config.icons.solid
                        color: Config.colors.foreground
                    }
		    ProgressIndicator {
			Layout.fillWidth: true
                        value: AudioService.volume
		    }
                }
            }
        }
    }
}
