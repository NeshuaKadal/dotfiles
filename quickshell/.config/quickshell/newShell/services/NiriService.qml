pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property var workspaces: []

    readonly property string focusedOutput: {
	const focused = root.workspaces.find(ws => ws.is_focused);
	return focused ? focused.output : "";
    }

    function sortWorkspaces(list) {
        return [...list].sort((a, b) => a.idx - b.idx);
    }

    Socket {
        id: socket
        path: Quickshell.env("NIRI_SOCKET")
        connected: true

        onConnectedChanged: {
            if (connected) write('"EventStream"\n');
        }

	parser: SplitParser {
	    onRead: line => {
		if (!line) return;
		try {
		    const event = JSON.parse(line);
		    if (event.WorkspacesChanged) {
			root.workspaces = root.sortWorkspaces(event.WorkspacesChanged.workspaces);
		    } else if (event.WorkspaceActivated) {
			const activeId = event.WorkspaceActivated.id;
			const activeWs = root.workspaces.find(ws => ws.id === activeId);
			const output = activeWs ? activeWs.output : null;
			root.workspaces = root.workspaces.map(ws => {
			    return {
				id: ws.id,
				idx: ws.idx,
				name: ws.name,
				output: ws.output,
				is_urgent: ws.is_urgent,
				active_window_id: ws.active_window_id,
				is_focused: ws.id === activeId,
				is_active: ws.output === output ? ws.id === activeId : ws.is_active
			    };
			});
		    }
		} catch (e) {
		    console.log("NiriService: parse error:", e, "for line:", line);
		}
	    }
	}
    }

    function focusWorkspace(idx) {
        Quickshell.execDetached(["niri", "msg", "action", "focus-workspace", String(idx)]);
    }
}
