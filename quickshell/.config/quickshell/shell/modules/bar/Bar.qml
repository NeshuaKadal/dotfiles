// modules/bar/Bar.qml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import qs.shared
import qs.services
import qs.config
import qs.components
import qs.components.controls

import "./widgets"

PanelWindow {
    id: root

    anchors {
	top: true
	left: true
	right: true
    }

    implicitHeight: Config.bar.height
    color: "transparent"

    BackgroundEffect.blurRegion: Region { item: bar; radius: bar.radius }

    exclusiveZone: implicitHeight
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell: bar"

    Rectangle {
	id: bar
	anchors.fill: parent
	color: Colors.alpha(Colors.surface, Config.bar.alpha)
	radius: Config.bar.radius

	Rectangle {
	    anchors.left: parent.left
	    anchors.right: parent.right
	    anchors.bottom: parent.bottom
	    height: Config.bar.border
	    color: Colors.alpha(Colors.outline, 0.25)
	}

	RowLayout {
	    anchors.fill: parent
	    anchors.leftMargin: Config.bar.margins
	    anchors.rightMargin: Config.bar.margins
	    spacing: Config.bar.spacing

	    Workspaces {}

	    Item { Layout.fillWidth: true }

	    TextButton {
		text: "Save"
		type: ButtonBase.Filled
		color: "primary"
		size: "s"
	    }

	    TextButton {
		text: "Extra Small"
		type: ButtonBase.Filled
		color: "tertiary"
		size: "xs"
	    }

	    TextButton {
		text: "2ndary"
		type: ButtonBase.Filled
		color: "secondary"
		size: "xs"
	    }

	    TextButton {
		text: "Cancel"
		type: ButtonBase.Text
		color: "secondary"
		size: "xs"
	    }

	    Button {
		text: "Button"
		variant: "primary"
	    }

	    IconButton {
		text: "1"
		isIcon: false
	    }
	}

	Clock { anchors.centerIn: parent }

    }
}
