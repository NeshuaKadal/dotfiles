// services/Colors.qml
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property color m3primary: "#89b4fa"
    property color m3onPrimary: "#1e1e2e"
    property color m3secondary: "#89b4fa"
    property color m3onSecondary: "#1e1e2e"
    property color m3tertiary: "#89b4fa"
    property color m3onTertiary: "#1e1e2e"
    property color m3background: "#1e1e2e"
    property color m3onBackground: "#cdd6f4"
    property color m3surface: "#1e1e2e"
    property color m3onSurface: "#cdd6f4"
    property color m3surfaceVariant: "#1e1e2e"
    property color m3onSurfaceVariant: "#cdd6f4"
    property color m3outline: "#6c7086"
    property color m3error: "#f38ba8"

    function applyScheme(data) {
        if (data.primary) root.m3primary = data.primary;
        if (data.on_primary) root.m3onPrimary = data.on_primary;
        if (data.secondary) root.m3secondary = data.secondary;
        if (data.on_secondary) root.m3onSecondary = data.on_secondary;
        if (data.tertiary) root.m3tertiary = data.tertiary;
        if (data.on_tertiary) root.m3onTertiary = data.on_tertiary;
        if (data.background) root.m3background = data.background;
        if (data.on_background) root.m3onBackground = data.on_background;
        if (data.surface) root.m3surface = data.surface;
        if (data.on_surface) root.m3onSurface = data.on_surface;
        if (data.surface_variant) root.m3surfaceVariant = data.surface_variant;
        if (data.on_surface_variant) root.m3onSurfaceVariant = data.on_surface_variant;
        if (data.outline) root.m3outline = data.outline;
        if (data.error) root.m3error = data.error;
    }

    FileView {
        path: Quickshell.env("HOME") + "/.config/quickshell/coolShell/shared/colors.json"
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            try { root.applyScheme(JSON.parse(text())); }
            catch (e) { console.log("Colors parse failed:", e); }
        }
    }
}
