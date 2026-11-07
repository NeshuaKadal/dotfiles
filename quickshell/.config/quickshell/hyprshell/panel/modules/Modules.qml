pragma Singleton
import Quickshell
import qs.components

Singleton {
    property list<PanelModule> all: [
	DefaultModule {}
    ]

    function viewFor(name) {
        let fallback = null
        for (let i = 0; i < all.length; i++) {
            if (all[i].name === name) return all[i].view
            if (all[i].name === "default") fallback = all[i].view
        }
        return fallback
    }
}
