// modules/panel/screens/Clock.qml
import QtQuick
import Quickshell
import qs.config
import qs.services

Item {
    ColumnLayout {
	Text {
	    anchors.centerIn: parent
	    text: Time.time()
	    horizontalAlignment: Text.AlignHCenter
	    color: Theme.mOnSurface
	    font.pixelSize: Theme.font.large
	    font.family: Theme.font.family
	}
	Text {
	    anchors.centerIn: parent
	    text: "Home"
	    horizontalAlignment: Text.AlignHCenter
	    color: Theme.mOnSurface
	    font.pixelSize: Theme.font.large
	    font.family: Theme.font.family
	}
    }
}
