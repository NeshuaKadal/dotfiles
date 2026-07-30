import QtQuick
import qs.config
import qs.services

Item {
    id: root
    required property real value
    signal moved(real value)

    implicitHeight: 20

    readonly property real handleWidth: dragArea.pressed ? 3 : 4
    readonly property real handleHeight: 30
    readonly property real gap: 4
    readonly property real trackHeight: 10

    readonly property real handleX: (root.width - handleWidth) * root.value

    // Active track
    Rectangle {
	x: 0
	y: (root.height - height) / 2
	width: Math.max(0, root.handleX - root.gap)
	height: root.trackHeight
	topLeftRadius: height / 2
	bottomLeftRadius: height / 2
	topRightRadius: 0
	bottomRightRadius: 0
	color: Config.colors.accent
    }

    // Inactive track
    Rectangle {
	id: inactiveTrack
	x: root.handleX + root.handleWidth + root.gap
	y: (root.height - height) / 2
	width: Math.max(0, root.width - x)
	height: root.trackHeight
	topLeftRadius: 0
	bottomLeftRadius: 0
	topRightRadius: height / 2
	bottomRightRadius: height / 2
	color: ColorUtils.withAlpha(Config.colors.foreground, 0.2)
    }
    // Stop indicator dot
    Rectangle {
	x: root.width - 8
	y: (root.height - height) / 2
	width: 4
	height: 4
	radius: 2
	color: Config.colors.background
	visible: inactiveTrack.width > 10
    }

    // Handle
    Rectangle {
        id: handle
        x: root.handleX
        y: (root.height - height) / 2
        width: root.handleWidth
        height: root.handleHeight
        radius: width / 2
        color: Config.colors.accent

        Behavior on width { NumberAnimation { duration: 100 } }
    }

    MouseArea {
        id: dragArea
        anchors.fill: parent
        function updateFromX(mx) {
            root.moved(Math.max(0, Math.min(1, mx / width)));
        }
        onPressed: mouse => updateFromX(mouse.x)
        onPositionChanged: mouse => { if (pressed) updateFromX(mouse.x); }
    }
}
