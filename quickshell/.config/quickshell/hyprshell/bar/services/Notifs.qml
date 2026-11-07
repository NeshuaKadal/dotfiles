pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

Singleton {
    id: root

    property bool dnd: false
    property var history: []
    readonly property var list: server.trackedNotifications

    signal arrived()

    FileView {
	id: historyFile
	path: Quickshell.env("HOME") + "/.local/state/quickshell/notification-history.json"
	watchChanges: false
	onLoaded: {
	    try { root.history = JSON.parse(text()); }
	    catch (e) { root.history = []; }
	}
	onLoadFailed: (error) => { root.history = []; }
    }

    function saveHistory() {
        historyFile.setText(JSON.stringify(root.history));
    }

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

    NotificationServer {
	id: server
	keepOnReload: false
	actionsSupported: true
	bodySupported: true
	imageSupported: true

	onNotification: n => {
	    n.tracked = true;
	    root.history = [{
		appName: n.appName,
		summary: n.summary,
		body: n.body,
		image: n.image,
		appIcon: n.appIcon,
		urgency: n.urgency,
		expireTimeout: n.expireTimeout,
		time: Date.now()
	    }, ...root.history];
	    root.saveHistory();
	    root.arrived();
	}
    }
}
