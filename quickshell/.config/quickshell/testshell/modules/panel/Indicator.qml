// modules/panel/Indicator.qml
import QtQuick
import qs.config

Item {
    id: root

    readonly property int duration: 100
    readonly property real pitch: 80
    readonly property real spread: 8
    readonly property real curve: 2
    readonly property int count: Screens.list.length
    readonly property real reach: Math.min(3, count / 2)

    property int last: 0
    property real goal: 0
    property real pos: goal

    implicitHeight: 48
    clip: true

    Behavior on pos { SpringAnimation { spring: 6; damping: 0.3; epsilon: 0.001 } }

    Connections {
        target: PanelState

        function onCurrentChanged() {
            const n = root.count
            let delta = ((PanelState.current - root.last) % n + n) % n
            if (delta > n / 2)
                delta -= n
            root.goal += delta
            root.last = PanelState.current
        }
    }

    Repeater {
        model: Screens.list

        Text {
            id: label

            required property int index
            required property var modelData
            readonly property bool selected: index === PanelState.current

            readonly property real d: {
                const n = root.count
                const v = (((index - root.pos) % n) + n) % n
                return v >= n / 2 ? v - n : v
            }

            text: modelData.label
            color: selected ? Theme.mPrimary : Theme.mOnSurfaceVariant
            font.family: "Tiny5 Mono CRT"
            font.pixelSize: 16
            font.capitalization: Font.AllUppercase
	    font.letterSpacing: selected ? 3 : 1

            x: root.width / 2 - width / 2 + root.pitch * d + root.spread * d * Math.abs(d)
            y: root.height / 2 - height / 2 + root.curve * d * d
            opacity: Math.max(0, 1 - Math.abs(d) / root.reach)
            visible: opacity > 0

            Behavior on color { ColorAnimation { duration: root.duration } }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: PanelState.goto(label.index)
            }
        }
    }
}
