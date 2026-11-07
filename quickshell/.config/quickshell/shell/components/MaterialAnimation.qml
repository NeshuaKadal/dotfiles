import QtQuick
import qs.config

NumberAnimation {
    id: root
    property string variant: "standardDefaultEffects"

    duration: Tokens.motion.duration[variant] ?? Tokens.motion.duration.standardDefaultEffects
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Tokens.motion.curve[variant] ?? Tokens.motion.curve.standardDefaultEffects
}
