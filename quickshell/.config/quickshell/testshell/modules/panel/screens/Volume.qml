// modules/panel/screens/Clock.qml
import QtQuick
import Quickshell
import qs.config

Item {
    Text {
	anchors.centerIn: parent
	text: "Volume"
	horizontalAlignment: Text.AlignHCenter
	color: Theme.mOnSurface
	font.pixelSize: Theme.font.large
	font.family: Theme.font.family
    }
}
