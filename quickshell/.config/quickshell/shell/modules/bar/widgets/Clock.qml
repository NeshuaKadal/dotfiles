import QtQuick
import qs.config
import qs.shared
import qs.services

Rectangle {
    radius: Config.bar.radius
    height: Config.bar.widgetHeight
    width: time.implicitWidth + Config.bar.widgetWidth / 2
    color: Colors.alpha( Colors.on_surface, mouseArea.pressed ? 0.16 : (mouseArea.containsMouse ? 0.08 : 0) )
    scale: mouseArea.pressed ? 0.95 : 1.0

    Behavior on color { ColorAnimation { duration: 100 } }
    Behavior on scale { NumberAnimation { duration: 100 } }

    Text {
	id: time
	anchors.centerIn: parent
	color: Colors.on_surface
	font.family: Config.font.mono
	font.pixelSize: Config.font.size
	font.weight: 600
	text: Time.time12
    }

    MouseArea {
	id: mouseArea
	anchors.fill: parent
	hoverEnabled: true
	cursorShape: Qt.PointingHandCursor
	//onClicked: switchProc.doSwitch(modelData.idx)
    }
}
