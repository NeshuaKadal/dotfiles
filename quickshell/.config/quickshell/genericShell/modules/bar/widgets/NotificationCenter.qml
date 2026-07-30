import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

Item {
    id: root
    implicitWidth: icon.implicitWidth + 12
    implicitHeight: 26

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: ColorUtils.withAlpha(
            Config.colors.foreground,
            mouseArea.pressed ? 0.16 : (mouseArea.containsMouse ? 0.08 : 0)
        )
        Behavior on color { ColorAnimation { duration: 100 } }
    }

    Text {
        id: icon
        anchors.centerIn: parent
        text: NotificationService.doNotDisturb ? "" : ""
        font.pixelSize: Config.fonts.size.normal
        font.family: Config.icons.solid
        color: NotificationService.history.length > 0 ? Config.colors.accent : Config.colors.foreground
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                NotificationService.toggleDnd();
            } else {
                menu.menuShown = !menu.menuShown;
            }
        }
    }

    NotificationCenterMenu { id: menu }
}
