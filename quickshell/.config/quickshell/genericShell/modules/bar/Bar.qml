import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services
import "widgets"

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            WlrLayershell.namespace: "quickshell:bar"
            required property var modelData
            screen: modelData
            anchors { top: true; left: true; right: true }
            implicitHeight: 30
            color: ColorUtils.withAlpha(Config.colors.background, Config.opacities.background)

            RowLayout {
                id: leftSection
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10

                Workspaces { output: modelData.name }
            }

            RowLayout {
                id: rightSection
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10

		Tray {}
                Volume {}
                NotificationCenter {}
            }

            Clock { anchors.centerIn: parent }
        }
    }
}
