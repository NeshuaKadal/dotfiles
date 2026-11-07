import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "./widgets"

PanelWindow {
    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.namespace: "quickshell: widgets"
    WlrLayershell.exclusiveZone: -1

    color: "transparent"

    Clock {}
}
