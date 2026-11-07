import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs.config
import qs.shared
import qs.services

RowLayout {
    id: root
    spacing: 3

    property int radius: 0
    property int boxWidth: 24
    property int boxHeight: 24

    Repeater {
	model: Niri.workspaces
	delegate: Rectangle {
	    radius: Config.bar.radius
	    width: Config.bar.widgetWidth
	    height: Config.bar.widgetHeight

	    color: Colors.alpha(Colors.on_surface, mouseArea.pressed ? 0.16 : (mouseArea.containsMouse ? 0.08 : 0))
	    scale: mouseArea.pressed ? 0.95 : 1.0

	    Behavior on color { ColorAnimation { duration: 100 } }
	    Behavior on scale { NumberAnimation { duration: 100 } }

	    Text {
		anchors.centerIn: parent
		text: model.idx
		color: model.is_active ? Colors.on_surface : Colors.alpha(Colors.on_surface, 0.5)
		font.family: Config.font.mono
		font.pixelSize: Config.font.size
		Behavior on color { ColorAnimation { duration: 100 } }
	    }

	    MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		cursorShape: Qt.PointingHandCursor
		onClicked: switchProc.doSwitch(model.idx)
	    }
	}
    }

    Process {
	id: switchProc
	function doSwitch(idx) {
	    command = ["niri", "msg", "action", "focus-workspace", "" + idx]
	    running = true
	}
    }
}
