import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import qs.shared
import qs.services
import qs.config

Item {
    id: container

    readonly property color textColor: Colors.on_surface
    readonly property int padding: 80

    anchors.top: parent.top
    anchors.left: parent.left

    anchors.margins: padding

    implicitWidth: clock_time.implicitWidth
    implicitHeight: clock_time.implicitHeight + clock_day.implicitHeight

    Text {
	id: clock_time
	anchors.top: parent.top
	anchors.right: parent.right
	text: Time.time12
	font.family: Config.font.fancy
	font.pixelSize: Config.font.size + 150
	color: Qt.rgba(textColor.r, textColor.g, textColor.b, 0.85)
    }

    Text {
	id: clock_day
	anchors.top: clock_time.bottom
	anchors.horizontalCenter: clock_time.horizontalCenter
	text: Time.date("dd•MM•yy")
	font.family: Config.font.mono
	font.pixelSize: Config.font.size + 8
	font.letterSpacing: 10
	color: Qt.rgba(textColor.r, textColor.g, textColor.b, 0.75)
    }
}
