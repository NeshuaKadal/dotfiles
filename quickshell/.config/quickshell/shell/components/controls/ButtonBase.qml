import QtQuick
import qs.config
import qs.services
import qs.components
import qs.shared

Rectangle {
    id: root

    enum Type { Elevated, Filled, Tonal, Outlined, Text }
    property int type: ButtonBase.Filled

    property bool disabled: false
    property bool isToggle: false
    property bool checked: false
    property bool internalChecked: checked
    onCheckedChanged: internalChecked = checked

    // ---- shape ----
    // "xs" | "s" | "m" | "l" | "xl" — drives both the leaf's own size lookup
    // and this base's corner-radius lookup, so the two can never drift apart.
    property string size: "m"

    // corner radii pulled straight from Tokens.rounding — see Tokens.button.shape
    // for the size->rounding-step mapping (kept in Tokens, not duplicated here)
    readonly property var currentShape: Tokens.button.shape[size] ?? Tokens.button.shape.m

    // shape is round when unselected, square when selected/checked.
    property bool radiusMorph: true
    readonly property real fullRadius: implicitHeight / 2
    property real defaultRadius: fullRadius
    property real checkedRadius: currentShape.square
    property real pressedRadius: currentShape.pressed

    // color
    property color containerColor
    property color textColor
    property color checkedContainerColor: containerColor
    property color checkedTextColor: textColor
    property color disabledColor: Colors.alpha(Colors.on_surface, 0.1)
    property color disabledOnColor: Colors.alpha(Colors.on_surface, 0.38)
    property color outlineColor: Colors.alpha(Colors.outline, 0.5)

    readonly property color contentColor: {
        if (disabled) return disabledTextColor;
        return internalChecked ? checkedTextColor : textColor;
    }

    signal clicked

    required implicitWidth
    required implicitHeight

    radius: {
        if (radiusMorph && mouseArea.pressed) return pressedRadius;
        return internalChecked ? checkedRadius : defaultRadius;
    }

    color: {
        if (type === ButtonBase.Outlined || type === ButtonBase.Text) return "transparent";
        if (disabled) return disabledColor;
        return internalChecked ? checkedContainerColor : containerColor;
    }

    border.width: type === ButtonBase.Outlined ? 1.5 : 0
    border.color: type === ButtonBase.Outlined
        ? (disabled ? disabledColor : outlineColor)
        : "transparent"

    // NOTE: Elevated resolves container/content colour correctly but has no
    // shadow applied — no elevation token/system exists yet. Visually identical
    // to Tonal until that's added.

    scale: mouseArea.pressed ? 1.1 : mouseArea.containsMouse ? 1.05 : 1

    Behavior on scale  { MaterialAnimation { variant: "expressiveFastSpatial" } }
    Behavior on radius { MaterialAnimation { variant: "expressiveFastSpatial" } }
    Behavior on color        { MaterialAnimation { variant: "expressiveDefaultEffects" } }
    Behavior on border.color { MaterialAnimation { variant: "expressiveDefaultEffects" } }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: !root.disabled
        cursorShape: root.disabled ? Qt.ArrowCursor : Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: {
            if (root.isToggle) root.internalChecked = !root.internalChecked;
            root.clicked();
        }
    }
}
