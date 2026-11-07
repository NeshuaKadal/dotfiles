pragma Singleton
import Quickshell
import qs.config

Singleton {
    id: root

    readonly property list<ShellScreen> screens: Quickshell.screens.filter(s => Config.forScreen(s.name).enabled)

    function isExcluded(screen: ShellScreen): bool {
        return !Config.forScreen(screen.name).enabled;
    }
}
