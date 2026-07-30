pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import qs.config

Singleton {
    id: root

    readonly property var allowedPlayers: {
        const allowed = Config.player.allowedSources;
        return Mpris.players.values.filter(p => allowed.includes(p.desktopEntry));
    }

    readonly property MprisPlayer activePlayer: {
        for (const p of root.allowedPlayers) {
            if (p.isPlaying) return p;
        }
        return root.allowedPlayers[0] ?? null;
    }

    readonly property bool hasPlayer: activePlayer !== null

    property MprisPlayer selectedPlayer: null
    readonly property MprisPlayer displayedPlayer: root.selectedPlayer ?? root.activePlayer

    readonly property string title: displayedPlayer?.trackTitle || "Nothing playing"
    readonly property string artist: displayedPlayer?.trackArtist || ""
    readonly property string album: displayedPlayer?.trackAlbum || ""
    readonly property string artUrl: displayedPlayer?.trackArtUrl || ""
    readonly property bool isPlaying: displayedPlayer?.isPlaying ?? false
    readonly property real length: displayedPlayer?.length ?? 0
    property real position: displayedPlayer?.position ?? 0
    readonly property var activePlayers: root.allowedPlayers.filter(p => p.isPlaying || p === root.activePlayer)
    property bool seeking: false
    readonly property bool shuffleSupported: displayedPlayer?.shuffleSupported ?? false
    readonly property bool shuffle: displayedPlayer?.shuffle ?? false
    readonly property bool loopSupported: displayedPlayer?.loopSupported ?? false
    readonly property int loopState: displayedPlayer?.loopState ?? 0

    Timer {
        interval: 1000
        repeat: true
        running: root.isPlaying && !root.seeking
        onTriggered: {
            if (root.displayedPlayer) {
                root.displayedPlayer.positionChanged();
                root.position = root.displayedPlayer.position;
            }
        }
    }

    function selectPlayer(p) { root.selectedPlayer = p; }
    function togglePlay() { displayedPlayer?.togglePlaying(); }
    function next() { if (displayedPlayer?.canGoNext) displayedPlayer.next(); }
    function previous() { if (displayedPlayer?.canGoPrevious) displayedPlayer.previous(); }
    function seek(pos) { if (displayedPlayer?.canSeek) displayedPlayer.position = pos; }
    function toggleShuffle() { if (displayedPlayer?.shuffleSupported) displayedPlayer.shuffle = !displayedPlayer.shuffle; }
    function toggleRepeat() { if (!displayedPlayer) return; displayedPlayer.loopState = displayedPlayer.loopState === 0 ? 2 : 0; }

    function formatTime(seconds) {
	const m = Math.floor(seconds / 60);
	const s = Math.floor(seconds % 60);
	return `${m}:${s.toString().padStart(2, "0")}`;
    }
}
