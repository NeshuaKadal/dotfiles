import QtQuick
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
        text: AudioService.muted ? "" : ""
        font.pixelSize: Config.fonts.size.icon
        font.family: Config.icons.solid
        color: Config.colors.foreground
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        onClicked: menu.menuShown = !menu.menuShown
        onWheel: event => {
            const delta = event.angleDelta.y > 0 ? 0.01 : -0.01;
            AudioService.setVolume(AudioService.volume + delta);
        }
    }

    VolumeMenu { id: menu }
}
