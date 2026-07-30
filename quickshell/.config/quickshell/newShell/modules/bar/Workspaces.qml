import QtQuick
import qs.config
import qs.services

Row {
    id: root
    required property string output

    Repeater {
        model: NiriService.workspaces.filter(ws => ws.output === root.output)
        delegate: Rectangle {
            required property var modelData
            width: Math.max(20, label.implicitWidth + 10)
            height: 20
            radius: height / 2
            color: ColorUtils.withAlpha(
                Colors.m3onBackground,
                mouseArea.pressed ? 0.16 : (mouseArea.containsMouse ? 0.08 : 0)
            )
            Behavior on color { ColorAnimation { duration: 100 } }

            Text {
                id: label
                anchors.centerIn: parent
                text: String(modelData.idx)
                font.pixelSize: Config.fonts.sizes.normal
                font.family: Config.fonts.mono
                color: modelData.is_focused ? Colors.m3onBackground : Colors.m3surfaceVariant
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: NiriService.focusWorkspace(modelData.idx)
            }
        }
    }
}
