import QtQuick
import QtQuick.Shapes
import qs.config
import qs.services

Item {
    id: root
    property real value: 0.0
    property bool indeterminate: false
    property real strokeWidth: 4

    implicitWidth: 40
    implicitHeight: 40

    property real _rotation: 0
    NumberAnimation on _rotation {
        running: root.indeterminate
        loops: Animation.Infinite
        from: 0
        to: 360
        duration: 1200
    }

    // Track
    Shape {
        anchors.fill: parent
        ShapePath {
            strokeColor: ColorUtils.withAlpha(Config.colors.foreground, 0.2)
            strokeWidth: root.strokeWidth
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap
            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: (root.width - root.strokeWidth) / 2
                radiusY: (root.height - root.strokeWidth) / 2
                startAngle: 0
                sweepAngle: 360
            }
        }
    }

    // Active arc
    Shape {
        anchors.fill: parent
        rotation: root.indeterminate ? root._rotation : -90
        ShapePath {
            strokeColor: Config.colors.accent
            strokeWidth: root.strokeWidth
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap
            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: (root.width - root.strokeWidth) / 2
                radiusY: (root.height - root.strokeWidth) / 2
                startAngle: 0
                sweepAngle: root.indeterminate ? 90 : 360 * root.value
            }
        }
    }
}
