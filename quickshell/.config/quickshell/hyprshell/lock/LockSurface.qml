import QtQuick
import Quickshell.Wayland
import qs.bar.services
import qs.wallpaper

WlSessionLockSurface {
    id: surface
    property var ctx

    readonly property color fg: Qt.rgba(222/255, 222/255, 222/255, 1)
    readonly property color danger: Qt.rgba(1, 0.3, 0.3, 1)

    color: Qt.rgba(14/255, 14/255, 14/255, 1)

    Image {
	anchors.fill: parent
	source: WallpaperService.lockImage ? "file://" + WallpaperService.lockImage : ""
	fillMode: Image.PreserveAspectCrop
	asynchronous: false
	visible: status === Image.Ready
    }

    component Label: Text {
	color: surface.fg
	font.family: "JetBrainsMono Nerd Font"
	font.weight: 700
    }

    MouseArea {
	anchors.fill: parent
	onClicked: input.forceActiveFocus()
    }

    Connections {
	target: surface.ctx
	function onBufferChanged() {
	    if (input.text !== surface.ctx.buffer) input.text = surface.ctx.buffer
	}
    }


    Column {
	id: stack
	anchors.left: parent.left
	anchors.top: parent.top
	anchors.leftMargin: 200
	anchors.topMargin: 100
	spacing: 850

	Column {
	    id: timeBlock
	    spacing: 0

	    Label {
		id: clock
		font.family: "Playfair Display"
		font.pixelSize: 180
		text: Time.time(12)
	    }
	    Label {
		id: date
		anchors.horizontalCenter: parent.horizontalCenter

		font.pixelSize: 20
		font.letterSpacing: 6
		font.capitalization: Font.AllUppercase
		leftPadding: font.letterSpacing

		text: Time.date("ddd - MMM - d")
		opacity: 0.8
	    }
	}

	Column {
	    id: inputGroup
	    spacing: 12

	    Rectangle {
		width: 400
		height: 36
		color: "transparent"

		Rectangle {
		    anchors.left: parent.left
		    anchors.right: parent.right
		    anchors.bottom: parent.bottom
		    height: 2
		    color: surface.ctx.failed ? surface.danger : Qt.rgba(1, 1, 1, 0.25)
		    Behavior on color { ColorAnimation { duration: 120 } }
		}

		Row {
		    anchors.centerIn: parent
		    spacing: 6
		    Repeater {
			model: surface.ctx.buffer.length
			Rectangle { width: 8; height: 8; color: surface.fg }
		    }
		}

		TextInput {
		    id: input
		    width: 1
		    height: 1
		    opacity: 0
		    echoMode: TextInput.Password
		    cursorDelegate: Item {}
		    focus: true
		    readOnly: surface.ctx.busy
		    Component.onCompleted: forceActiveFocus()

		    onTextChanged: surface.ctx.buffer = text
		    onAccepted: surface.ctx.submit()
		    Keys.onEscapePressed: text = ""
		}
	    }

	    Label {
		anchors.horizontalCenter: parent.horizontalCenter

		color: surface.ctx.failed ? surface.danger : surface.fg
		font.pixelSize: 11
		font.letterSpacing: 6
		font.capitalization: Font.AllUppercase
		leftPadding: font.letterSpacing

		text: surface.ctx.busy ? "VERIFYING" : surface.ctx.failed ? "ACCESS DENIED" : "ENTER PASSWORD"
		opacity: 0.6
	    }
	}
    }
}
