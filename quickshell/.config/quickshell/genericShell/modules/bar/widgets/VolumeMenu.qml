import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services
import qs.components

MenuWindow {
    WlrLayershell.namespace: "quickshell:menu"
    id: root
    menuShown: false
    anchors { top: true; right: true }
    margins { top: 8; right: 8 }
    implicitWidth: 380
    implicitHeight: content.implicitHeight + 40
    exclusiveZone: 0

    Rectangle {
        anchors.fill: parent
        radius: 20
        color: ColorUtils.withAlpha(Config.colors.background, Config.opacities.background)

        ColumnLayout {
            id: content
            anchors.fill: parent
            anchors.margins: 15
            spacing: 10

            RowLayout {
                Text {
                    text: "Volume"
                    color: Config.colors.foreground
                    font.pixelSize: Config.fonts.size.medium
                    font.family: Config.fonts.mono
                    Layout.fillWidth: true
                }
                IconButton {
                    icon: ""
                    onClicked: root.menuShown = false
                }
            }

            Divider {}

            ExpandableSection {
                title: "Output"
                currentValue: AudioService.sink ? AudioService.displayName(AudioService.sink) : "No output"
                Repeater {
                    model: AudioService.sinks
                    delegate: SelectableItem {
                        required property var modelData
                        label: AudioService.displayName(modelData)
                        selected: AudioService.sink?.id === modelData.id
                        onActivated: AudioService.setSink(modelData)
                    }
                }
            }

            RowLayout {
                ToggleIconButton {
                    checked: AudioService.muted
                    iconOn: ""
                    iconOff: ""
                    onToggled: AudioService.toggleMute()
                }
                Slider {
                    Layout.fillWidth: true
                    value: AudioService.volume
                    onMoved: v => AudioService.setVolume(v)
                }
            }

            Divider {}

            ExpandableSection {
                title: "Input"
                currentValue: AudioService.source ? AudioService.displayName(AudioService.source) : "No input"
                Repeater {
                    model: AudioService.sources
                    delegate: SelectableItem {
                        required property var modelData
                        label: AudioService.displayName(modelData)
                        selected: AudioService.source?.id === modelData.id
                        onActivated: AudioService.setSource(modelData)
                    }
                }
            }

            RowLayout {
                ToggleIconButton {
                    checked: AudioService.sourceMuted
                    iconOn: ""
                    iconOff: ""
                    onToggled: AudioService.toggleSourceMute()
                }
                Slider {
                    Layout.fillWidth: true
                    value: AudioService.sourceVolume
                    onMoved: v => AudioService.setSourceVolume(v)
                }
            }
        }
    }
}
