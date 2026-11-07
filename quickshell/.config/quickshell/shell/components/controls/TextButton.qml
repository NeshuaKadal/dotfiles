import QtQuick
import qs.components.controls
import qs.services
import qs.shared
import qs.config

ButtonBase {
    id: root

    property string text: ""
    property string color: "primary"   // primary | secondary | tertiary | surface | surface_variant

    readonly property var currentSize: Tokens.button.size[root.size] ?? Tokens.button.size.m
    readonly property var roleColors: Colors.roles[color] ?? Colors.roles.primary

    property color baseColor: roleColors.base
    property color baseTextColor: roleColors.on
    property color containerTone: roleColors.container
    property color containerToneText: roleColors.onContainer

    readonly property bool isTogglable: isToggle && type !== ButtonBase.Text

    containerColor: {
	if (type === ButtonBase.Elevated) return Colors.surface_container_low;
	if (type === ButtonBase.Tonal) return containerTone;
	if (type === ButtonBase.Filled && isTogglable) return Colors.surface_container;
	return baseColor;
    }

    textColor: {
	if (type === ButtonBase.Elevated) return baseColor;
	if (type === ButtonBase.Tonal) return containerToneText;
	if (type === ButtonBase.Outlined || type === ButtonBase.Text) return baseColor;
	if (type === ButtonBase.Filled && isTogglable) return Colors.on_surface_variant;
	return baseTextColor;
    }

    checkedContainerColor: {
	if (type === ButtonBase.Outlined) return Colors.inverse_surface;
	return baseColor;
    }

    checkedTextColor: {   // was: checkedOnColor
	if (type === ButtonBase.Outlined) return Colors.inverse_on_surface;
	return baseTextColor;
    }

    implicitWidth: label.implicitWidth + currentSize.padH * 2
    implicitHeight: currentSize.height

    Component.onCompleted: {
	if (type === ButtonBase.Text && isToggle)
	console.warn("Button: No toggle variant for the Text style");
    }

    Text {
	id: label
	anchors.centerIn: parent
	text: root.text
	font.family: Config.font.mono
	font.pixelSize: root.currentSize.font
	color: root.contentColor
    }
}
