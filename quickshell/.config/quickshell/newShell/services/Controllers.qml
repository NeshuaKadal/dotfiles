pragma Singleton
import QtQuick
import Quickshell
import qs.services

Singleton {
    function forceInit() {}

    Connections {
        target: AudioService
        function onVolumeChanged() { UiState.flash("volume-osd", 1500) }
        function onMutedChanged() { UiState.flash("volume-osd", 1500) }
        function onSourceVolumeChanged() { UiState.flash("source-volume-osd", 1500) }
        function onSourceMutedChanged() { UiState.flash("source-volume-osd", 1500) }
    }

    Connections {
	target: NotificationService
	function onNotificationArrived() {
	    if (!NotificationService.doNotDisturb) {
		UiState.flash("notification-osd", 4000);
	    }
	}
    }

    Connections {
	target: PlayerService
	function onTitleChanged() { UiState.flash("player-osd", 2000) }
	function onIsPlayingChanged() { UiState.flash("player-osd", 2000) }
    }
}
