import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import qs.bar.components
import qs.bar.services

BarModule {
    id: mod
    name: "music"

    // prefer whichever player is actually playing, else the first one
    readonly property var player: {
        const list = Array.from(Mpris.players.values)
        return list.find(p => p.isPlaying) ?? list[0] ?? null
    }

    readonly property bool expanded: BarState.sticky
    readonly property int maxTextWidth: 520
    readonly property int flashMs: 3000

    GlobalShortcut {
        appid: "quickshell"
        name: "music"
        onPressed: BarState.toggle("music")
    }
    IpcHandler {
        target: "music"
        function toggle(): void { BarState.toggle("music") }
    }

    // brief popup on track change or play/pause
    Connections {
        target: mod.player ?? null
        ignoreUnknownSignals: true
        function onTrackTitleChanged() { if (mod.player?.trackTitle) BarState.flash("music", mod.flashMs) }
        function onIsPlayingChanged()  { BarState.flash("music", mod.flashMs) }
    }

    view: Component {
        Row {
            spacing: 6
            leftPadding: 6
            rightPadding: mod.expanded ? 0 : 6

            HoverHandler { id: hover }
            // expanded mode closes itself 4s after the pointer leaves (or was never there)
            Timer {
                running: mod.expanded && !hover.hovered
                interval: 3000
                onTriggered: BarState.close()
            }

	    Item {
		anchors.verticalCenter: parent.verticalCenter
		width: 12
		height: 12

		Image {
		    id: art
		    anchors.fill: parent
		    source: mod.player?.trackArtUrl ?? ""
		    sourceSize: Qt.size(24, 24)
		    fillMode: Image.PreserveAspectCrop
		    visible: status === Image.Ready
		}
		BarText {
		    anchors.centerIn: parent
		    visible: !art.visible
		    text: "󰎆"
		    font.pixelSize: 10
		}
	    }

	    BarText {
		anchors.verticalCenter: parent.verticalCenter
		width: Math.min(implicitWidth, mod.maxTextWidth)
		elide: Text.ElideRight
		font.capitalization: Font.AllUppercase
		opacity: mod.player?.isPlaying ? 1 : 0.4
		text: {
		    const p = mod.player
		    if (!p) return "nothing playing"
		    const parts = [p.trackTitle, p.trackArtist, p.trackAlbum]
		    return parts.filter(s => s).join(" - ")
		}
		MouseArea {
		    anchors.fill: parent
		    onClicked: mod.player?.togglePlaying()
		}
	    }
        }
    }
}
