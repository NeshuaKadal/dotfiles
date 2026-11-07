pragma Singleton
import Quickshell
import qs.bar.components

Singleton {
    property list<BarModule> all: [
        ClockModule {},
        WorkspacesModule {},
        VolumeModule {},
        PowerModule {},
        LauncherModule {},
	MpdModule {},
	MusicModule {},
	NotificationsModule {}
    ]

    function viewFor(name) {
        let fallback = null
        for (let i = 0; i < all.length; i++) {
            if (all[i].name === name) return all[i].view
            if (all[i].name === "clock") fallback = all[i].view
        }
        return fallback
    }
}
