pragma Singleton
import QtQuick
import Quickshell

Singleton {
    property color primary: "{{colors.primary.default.hex}}"
    property color on_primary: "{{colors.on_primary.default.hex}}"
    property color primary_container: "{{colors.primary_container.default.hex}}"
    property color on_primary_container: "{{colors.on_primary_container.default.hex}}"

    property color secondary: "{{colors.secondary.default.hex}}"
    property color on_secondary: "{{colors.on_secondary.default.hex}}"
    property color secondary_container: "{{colors.secondary_container.default.hex}}"
    property color on_secondary_container: "{{colors.on_secondary_container.default.hex}}"

    property color tertiary: "{{colors.tertiary.default.hex}}"
    property color on_tertiary: "{{colors.on_tertiary.default.hex}}"
    property color tertiary_container: "{{colors.tertiary_container.default.hex}}"
    property color on_tertiary_container: "{{colors.on_tertiary_container.default.hex}}"

    property color error: "{{colors.error.default.hex}}"
    property color on_error: "{{colors.on_error.default.hex}}"
    property color error_container: "{{colors.error_container.default.hex}}"
    property color on_error_container: "{{colors.on_error_container.default.hex}}"

    property color surface_dim: "{{colors.surface_dim.default.hex}}"
    property color surface: "{{colors.surface.default.hex}}"
    property color surface_bright: "{{colors.surface_bright.default.hex}}"

    property color surface_container_low: "{{colors.surface_container_low.default.hex}}"
    property color surface_container: "{{colors.surface_container.default.hex}}"
    property color surface_container_high: "{{colors.surface_container_high.default.hex}}"

    property color on_surface: "{{colors.on_surface.default.hex}}"
    property color on_surface_variant: "{{colors.on_surface_variant.default.hex}}"
    property color outline: "{{colors.outline.default.hex}}"
    property color outline_variant: "{{colors.outline_variant.default.hex}}"

    property color inverse_surface: "{{colors.inverse_surface.default.hex}}"
    property color inverse_on_surface: "{{colors.inverse_on_surface.default.hex}}"
    property color inverse_primary: "{{colors.inverse_primary.default.hex}}"

    property color shadow: "{{colors.shadow.default.hex}}"
    property color scrim: "{{colors.scrim.default.hex}}"

    readonly property var roles: ({
	primary:   { base: primary,   on: on_primary,   container: primary_container,   onContainer: on_primary_container },
	secondary: { base: secondary, on: on_secondary, container: secondary_container, onContainer: on_secondary_container },
	tertiary:  { base: tertiary,  on: on_tertiary,  container: tertiary_container,  onContainer: on_tertiary_container },
	error:     { base: error,     on: on_error,     container: error_container,     onContainer: on_error_container },
	surface:   { base: surface,   on: on_surface,   container: surface_container,   onContainer: on_surface_variant }
    })

    function alpha(color, alpha) {
	return Qt.rgba(color.r, color.g, color.b, alpha)
    }
}
