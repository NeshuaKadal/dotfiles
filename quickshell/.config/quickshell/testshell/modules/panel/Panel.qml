// modules/panel/Panel.qml
import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config

PanelWindow {
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell: panel"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    visible: PanelState.visible
    screen: PanelState.screen

    anchors {
	left: true
	top: true
	bottom: true
    }

    margins {
	left: 8
	top: 8
	bottom: 8
    }

    implicitWidth: 400
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"


    Rectangle {
	id: card
	anchors.fill: parent
	color: Qt.alpha(Theme.mSurface, Theme.panelOpacity)
	radius: Theme.radius
	border.width: Theme.borderWidth
	border.color: Theme.mOutline

	focus: true
	Keys.onEscapePressed: PanelState.toggle()
	Keys.onLeftPressed: PanelState.prev()
	Keys.onRightPressed: PanelState.next()

	Loader {
	    anchors {
		top: parent.top
		left: parent.left
		right: parent.right
		bottom: parent.bottom
	    }
	    active: PanelState.visible
	    source: Screens.list[PanelState.current].source
	}

	Indicator {
	    id: indicator
	    anchors {
		left: parent.left
		right: parent.right
		bottom: parent.bottom
	    }
	}
    }
}
