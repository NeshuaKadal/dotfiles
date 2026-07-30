pragma Singleton
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink?.audio.muted ?? false
    readonly property real volume: sink?.audio.volume ?? 0

    readonly property PwNode source: Pipewire.defaultAudioSource
    readonly property bool sourceMuted: source?.audio.muted ?? false
    readonly property real sourceVolume: source?.audio.volume ?? 0

    readonly property var sinks: Pipewire.nodes.values.filter(n => n.audio && !n.isStream && n.isSink)
    readonly property var sources: Pipewire.nodes.values.filter(n => n.audio && !n.isStream && !n.isSink)

    PwObjectTracker { objects: [sink, source] }

    function setSink(node) { Pipewire.preferredDefaultAudioSink = node; }
    function setVolume(v) {
        if (sink?.audio) {
            sink.audio.muted = false;
            sink.audio.volume = Math.max(0, Math.min(1, v));
        }
    }
    function toggleMute() { if (sink?.audio) sink.audio.muted = !sink.audio.muted; }

    function setSource(node) { Pipewire.preferredDefaultAudioSource = node; }
    function setSourceVolume(v) {
        if (source?.audio) {
            source.audio.muted = false;
            source.audio.volume = Math.max(0, Math.min(1, v));
        }
    }
    function toggleSourceMute() { if (source?.audio) source.audio.muted = !source.audio.muted; }

    function displayName(node) {
        return node.nickname || node.description || node.name;
    }
}
