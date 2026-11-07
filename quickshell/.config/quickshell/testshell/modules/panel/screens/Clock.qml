// modules/panel/screens/Clock.qml
import QtQuick
import Quickshell
import qs.config
import qs.services

Item {
    Text {
	anchors.centerIn: parent
	text: Time.time()
	horizontalAlignment: Text.AlignHCenter
	color: Theme.mOnSurface
	font.pixelSize: Theme.font.large
	font.family: Theme.font.family
    }
}
