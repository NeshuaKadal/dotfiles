import QtQuick
import QtQuick.Layouts

import qs.config
import qs.services
import qs.shared
import qs.components

Item {
    id: root
    property string text: ""
    property bool rounded: Config.button.rounded
    property bool isIcon: true
    property string variant: "primary" // "surface" | "surface_variant" | "primary" | "secondary" | "tertiary | "error"
    property int size: 26
    signal clicked

    readonly property color baseColor: Colors[root.variant] ?? Colors.primary
    readonly property color onColor: Colors["on_" + root.variant] ?? Colors.on_primary

    implicitWidth: Math.max(size, label.implicitWidth + size / 2)
    implicitHeight: size

    scale: mouseArea.pressed ? 0.9 : 1.0
    Behavior on scale { MaterialAnimation { variant: "expressiveFastSpatial" } }

    Rectangle {
	id: button
        anchors.fill: parent
	radius: root.rounded ? root.implicitHeight / 2 : 0
        color: Colors.alpha(root.baseColor, mouseArea.pressed ? 0.25 : (mouseArea.containsMouse ? 0.15 : 0))
        Behavior on color { ColorAnimation { duration: 100 } }
    }

    Text {
	id: label
        anchors.centerIn: parent
        text: root.text
        font.family: isIcon ? Config.font.icon : Config.font.mono
        font.pixelSize: root.size / 2
        color: root.baseColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
