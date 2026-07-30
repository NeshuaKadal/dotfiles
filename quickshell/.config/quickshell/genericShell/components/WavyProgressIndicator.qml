import QtQuick
import QtQuick.Shapes
import qs.config
import qs.services

Item {
    id: root
    property real value: 0.0
    property bool indeterminate: false
    property real amplitude: 0.6      // 0.0 flat - 1.0 full wave
    property real wavelength: 20
    property real waveSpeed: 20       // px/sec

    implicitHeight: 12
    readonly property real trackHeight: 4
    readonly property real gap: 4

    property real _phase: 0
    NumberAnimation on _phase {
        running: root.amplitude > 0
        loops: Animation.Infinite
        from: 0
        to: root.wavelength
        duration: (root.wavelength / root.waveSpeed) * 1000
    }

    readonly property real activeWidth: root.indeterminate ? root.width * 0.35 : root.width * root.value
    property real _indeterminateX: 0
    SequentialAnimation on _indeterminateX {
        running: root.indeterminate
        loops: Animation.Infinite
        NumberAnimation { from: -root.activeWidth; to: root.width; duration: 1200; easing.type: Easing.InOutCubic }
    }

    // Track (inactive)
    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: root.trackHeight
        radius: height / 2
        color: ColorUtils.withAlpha(Config.colors.foreground, 0.2)
    }

    // Wavy active segment
    Shape {
        id: waveShape
        anchors.fill: parent
        x: root.indeterminate ? root._indeterminateX : 0
        width: root.activeWidth

        ShapePath {
            strokeColor: Config.colors.accent
            strokeWidth: root.trackHeight
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            PathPolyline {
                path: {
                    const pts = [];
                    const amp = (root.trackHeight / 2) * root.amplitude;
                    const midY = waveShape.height / 2;
                    const w = root.amplitude > 0 ? waveShape.width : 0;
                    for (let px = 0; px <= w; px += 2) {
                        const y = midY + amp * Math.sin((2 * Math.PI * (px + root._phase)) / root.wavelength);
                        pts.push(Qt.point(px, y));
                    }
                    return pts;
                }
            }
        }
    }
}
