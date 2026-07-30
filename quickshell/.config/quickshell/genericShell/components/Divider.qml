import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services

Rectangle {
    Layout.fillWidth: true
    implicitHeight: 1
    color: ColorUtils.withAlpha(Config.colors.foreground, 0.15)
}
