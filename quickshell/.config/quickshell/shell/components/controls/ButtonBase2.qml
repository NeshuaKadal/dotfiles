import QtQuick
import qs.config
import qs.services
import qs.components
import qs.shared

Rectangle {
    id: root

    enum Type { Filled, Tonal, Text }

    property int type: ButtonBase.Filled

    property bool checked: false
    property bool disabled: false
    property bool isToggle: false
    property bool internalChecked: checked
    onCheckedChanged: internalChecked = checked

    property string size: "m"
    readonly property var shape: Tokens.button.shape[size] ?? Tokens.button.shape.m

    readonly property bool radiusMorph: true
    readonly property real defaultRadius: implicitHeight / 2
    readonly property real checkedRadius: shape.square
    readonly property real pressedRadius: shape.pressed

    property string color: "primary"
    readonly property var colorRole: Colors.roles[color] ?? Colors.roles.primary

    readonly property color baseColor: colorRole.base
    readonly property color onColor: colorRole.on
    readonly property color containerColor: colorRole.container
    readonly property color onContainerColor: colorRole.onContainer
[]
    readonly property color checkedContainerColor: baseColor
    readonly property color checkedOnColor: onColor
    readonly property color disabledColor: Colors.alpha(Colors.on_surface, 0.1)
    readonly property color disabledOnColor: Colors.alpha(Colors.on_surface, 0.38)
    readonly property color outlineColor: Colors.alpha(Colors.outline, 0.5)

    readonly property color contentColor: {
        if (disabled) return disabledTextColor;
        return internalChecked ? checkedonColor : onColor;
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

