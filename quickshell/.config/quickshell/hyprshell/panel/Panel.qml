import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.services
import qs.panel.modules

PanelWindow {
    id: root

    anchors { top: true; bottom: true;  right: true}
    margins { top: 16; bottom: 8; right: 8 }

    implicitWidth: screen.width / 10 - 8

    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell: panel"
    WlrLayershell.keyboardFocus: BarState.keyboard ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    Rectangle {
        anchors.fill: parent
        color: Colors.mSurface
	border {
	    width: 2
	    color: Colors.mPrimary
	}

        Item {
            id: center
            anchors.centerIn: parent
            height: parent.height
            width: loader.item ? loader.item.implicitWidth : 0
            clip: true
            Behavior on width { NumberAnimation { duration: 120; easing.type: Easing.OutCubic } }

            Loader {
                id: loader
                anchors.centerIn: parent
                sourceComponent: Modules.viewFor(PanelState.mode)
            }
        }
    }
}

