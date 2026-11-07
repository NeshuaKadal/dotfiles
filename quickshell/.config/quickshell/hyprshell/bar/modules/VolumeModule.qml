import QtQuick
import Quickshell.Services.Pipewire
import qs.bar.components
import qs.bar.components.controls
import qs.bar.services

BarModule {
    id: mod
    name: "volume"

    readonly property var audio: Pipewire.defaultAudioSink?.audio ?? null

    view: Component {
        Row {
            spacing: 6

            BarText {
                anchors.verticalCenter: parent.verticalCenter
                text: mod.audio?.muted ? "MUTE" : "VOL"
            }

            ProgressBar {
                anchors.verticalCenter: parent.verticalCenter
                width: 200
                value: mod.audio?.volume ?? 0
                toggled: mod.audio?.muted
            }

            BarText {
                anchors.verticalCenter: parent.verticalCenter
                text: Math.round((mod.audio?.volume ?? 0) * 100) + "%"
            }
        }
    }

    PwObjectTracker { objects: [Pipewire.defaultAudioSink] }
    Connections {
	target: mod.audio
	ignoreUnknownSignals: true
        function onVolumeChanged() { BarState.flash("volume") }
        function onMutedChanged()  { BarState.flash("volume") }
    }
}
