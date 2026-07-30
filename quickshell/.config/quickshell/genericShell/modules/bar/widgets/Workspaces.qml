import QtQuick
import qs.config
import qs.services

Row {
    id: root
    required property string output
    spacing: 5

    Repeater {
        model: NiriService.workspaces.filter(ws => ws.output === root.output)
        delegate: Rectangle {
            required property var modelData
            width: Math.max(20, label.implicitWidth + 10)
            height: 20
            radius: 6
            color: ColorUtils.withAlpha(
                Config.colors.foreground,
                mouseArea.pressed ? 0.16 : (mouseArea.containsMouse ? 0.08 : 0)
            )

            Behavior on color { ColorAnimation { duration: 100 } }

            Text {
                id: label
                anchors.centerIn: parent
                text: Config.toggles.showWorkspaceIndexes ? String(modelData.idx) : (Config.workspaceNames[String(modelData.idx)] ?? modelData.idx)
                font.pixelSize: Config.fonts.size.normal
                font.family: Config.fonts.mono
                color: modelData.is_focused ? Config.colors.foreground : ColorUtils.withAlpha(Config.colors.foreground, 0.5)
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
