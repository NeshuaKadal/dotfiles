import QtQuick
import QtQuick.Layouts

import qs.config
import qs.services
import qs.shared
import qs.components

Item {
    id: root
    signal clicked
    property string text: ""
    property string variant: "primary" // "surface" | "surface_variant" | "primary" | "secondary" | "tertiary" | "error"
    property int size: 26
    property bool isIcon: false
    property bool isOutlined: false
    property bool isRounded: Config.button.rounded

    property color baseColor: Colors[root.variant] ?? Colors.primary
    property color onColor: Colors["on_" + root.variant] ?? Colors.on_primary

    implicitWidth: Math.max(size, label.implicitWidth + size / 1.5)
    implicitHeight: size

    scale: mouseArea.pressed ? 0.9 : 1.0
    Behavior on scale { MaterialAnimation { variant: "expressiveFastSpatial" } }

    Rectangle {
	id: button
	anchors.fill: parent
	radius: root.isRounded ? root.implicitHeight / 2 : 0
	color: root.isOutlined ? "transparent" : root.baseColor
	border.width: root.outlined ? 1.5 : 1
	border.color: root.outlined ? root.baseColor : Colors.alpha(root.baseColor, 0.5)
    }

    Text {
	id: label
	anchors.centerIn: parent
	text: root.text
	font.family: root.isIcon ? Config.font.icon : Config.font.mono
	font.pixelSize: root.size / 2
	color: root.isOutlined ? root.baseColor : root.onColor
    }

    MouseArea {
	id: mouseArea
	anchors.fill: parent
	onClicked: root.clicked()
    }
}

