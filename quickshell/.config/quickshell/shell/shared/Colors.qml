pragma Singleton
import QtQuick
import Quickshell

Singleton {
    property color primary: "#ffb3ae"
    property color on_primary: "#5f1414"
    property color primary_container: "#7e2a28"
    property color on_primary_container: "#ffdad7"

    property color secondary: "#e7bdb9"
    property color on_secondary: "#442927"
    property color secondary_container: "#5d3f3d"
    property color on_secondary_container: "#ffdad7"

    property color tertiary: "#e2c28c"
    property color on_tertiary: "#402d04"
    property color tertiary_container: "#594319"
    property color on_tertiary_container: "#ffdea6"

    property color error: "#ffb4ab"
    property color on_error: "#690005"
    property color error_container: "#93000a"
    property color on_error_container: "#ffdad6"

    property color surface_dim: "#131313"
    property color surface: "#131313"
    property color surface_bright: "#393939"

    property color surface_container_low: "#1b1b1b"
    property color surface_container: "#1f1f1f"
    property color surface_container_high: "#2a2a2a"

    property color on_surface: "#e2e2e2"
    property color on_surface_variant: "#c6c6c6"
    property color outline: "#919191"
    property color outline_variant: "#474747"

    property color inverse_surface: "#e2e2e2"
    property color inverse_on_surface: "#303030"
    property color inverse_primary: "#9c413d"

    property color shadow: "#000000"
    property color scrim: "#000000"

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
