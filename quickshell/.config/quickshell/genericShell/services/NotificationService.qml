// services/NotificationService.qml
pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import qs.config

Singleton {
    id: root

    property bool doNotDisturb: false
    property var history: []

    FileView {
        id: historyFile
        path: Quickshell.env("HOME") + "/.local/state/quickshell/notification-history.json"
        watchChanges: false
        onLoaded: {
            try {
                root.history = JSON.parse(text());
            } catch (e) {
                root.history = [];
            }
        }
        onLoadFailed: (error) => { root.history = []; }
    }

    function saveHistory() {
        historyFile.setText(JSON.stringify(root.history));
    }

    NotificationServer {
        id: server
        keepOnReload: false
        actionsSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: notification => {
            notification.tracked = true;

            root.history = [{
                summary: notification.summary,
                body: notification.body,
                appName: notification.appName,
                image: notification.image || notification.appIcon || "",
                urgency: notification.urgency,
                time: Date.now()
            }, ...root.history];
            root.saveHistory();

            if (root.doNotDisturb && notification.urgency !== NotificationUrgency.Critical) {
                notification.tracked = false;
            }
        }
    }

    readonly property var trackedNotifications: server.trackedNotifications

    function clearHistory() {
        root.history = [];
        root.saveHistory();
    }

    function removeAt(index) {
	root.history = root.history.filter((_, i) => i !== index);
	root.saveHistory();
    }

    function toggleDnd() {
        root.doNotDisturb = !root.doNotDisturb;
    }
}
