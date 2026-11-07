import QtQuick
import Quickshell
import Quickshell.Wayland

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData
        screen: modelData

        anchors { top: true; bottom: true; left: true; right: true }
        exclusionMode: ExclusionMode.Ignore
        color: "black"

        WlrLayershell.layer: WlrLayer.Background
        WlrLayershell.namespace: "quickshell: wallpaper"

        WallpaperImage {
            anchors.fill: parent
            source: WallpaperService.current ? "file://" + WallpaperService.current : ""
            targetWidth: modelData.width
        }
    }
}
