import QtQuick

Item {
    id: root
    required property real value          // 0..1

    property bool toggled: false
    property real gap: 4
    property real trackHeight: 5

    readonly property real clamped: Math.max(0, Math.min(1, value))
    readonly property real splitX: clamped * width

    implicitWidth: 60
    implicitHeight: trackHeight

    // Active track
    Rectangle {
        x: 0
        y: (root.height - height) / 2
        width: root.clamped >= 1 ? root.width : Math.max(0, root.splitX - root.gap / 2)
        height: root.trackHeight
        color: toggled ? Qt.rgba(1, 1, 1, 0.2) : Qt.rgba(222/255, 222/255, 222/255, 1)
    }

    // Inactive track
    Rectangle {
        id: inactiveTrack
        x: root.clamped <= 0 ? 0 : root.splitX + root.gap / 2
        y: (root.height - height) / 2
        width: Math.max(0, root.width - x)
        height: root.trackHeight
        color: Qt.rgba(1, 1, 1, 0.2)
    }

    // Stop indicator dot
    Rectangle {
        x: root.width - 4
        y: (root.height - height) / 2
        width: 3
        height: 3
        color: Qt.rgba(14/255, 14/255, 14/255, 1)
        visible: inactiveTrack.width > 5
    }
}
