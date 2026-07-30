import QtQuick
import qs.config
import qs.services

Item {
    id: root
    property real value: 0.0
    property bool indeterminate: false
    property real trackHeight: 10
    property real gap: 2
    property color activeColor: Config.colors.accent
    property color inactiveColor: ColorUtils.withAlpha(Config.colors.foreground, Config.opacities.muted)
    property bool showStopIndicator: true

    implicitHeight: Math.max(trackHeight, 8)

    readonly property real activeWidth: root.width * root.value

    // Active segment
    Rectangle {
	visible: !root.indeterminate
	x: 0
	y: (root.height - height) / 2
	width: Math.max(0, root.activeWidth - root.gap)
	height: root.trackHeight
	radius: height / 2
	color: root.activeColor
    }

    // Inactive segment
    Rectangle {
	id: inactiveTrack
	visible: !root.indeterminate
	x: root.activeWidth + root.gap
	y: (root.height - height) / 2
	width: Math.max(0, root.width - x)
	height: root.trackHeight
	radius: height / 2
	color: root.inactiveColor
    }

    // Stop indicator dot at the far end
    Rectangle {
	visible: !root.indeterminate && root.showStopIndicator && inactiveTrack.width > 10
	x: root.width - 8
	y: (root.height - height) / 2
	width: 4
	height: 4
	radius: 2
	color: Config.colors.background
    }

    // Indeterminate — looping segment
    Item {
        visible: root.indeterminate
        anchors.fill: parent
        clip: true

        Rectangle {
            id: indeterminateBar
            width: root.width * 0.35
            height: root.trackHeight
            radius: height / 2
            color: root.activeColor
            y: (root.height - height) / 2
            x: -width

            SequentialAnimation on x {
                running: root.indeterminate
                loops: Animation.Infinite
                NumberAnimation {
                    from: -indeterminateBar.width
                    to: root.width
                    duration: 1200
                    easing.type: Easing.InOutCubic
                }
            }
        }
    }
}
