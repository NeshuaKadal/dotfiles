pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property ListModel workspaces: ListModel {}

    function upsert(rawWs) {
	const ws = root.normalize(rawWs)
	for (let i = 0; i < workspaces.count; i++) {
	    if (workspaces.get(i).id === ws.id) {
		if (workspaces.get(i).idx !== ws.idx) workspaces.setProperty(i, "idx", ws.idx)
		if (workspaces.get(i).output !== ws.output) workspaces.setProperty(i, "output", ws.output)
		if (workspaces.get(i).is_active !== ws.is_active) workspaces.setProperty(i, "is_active", ws.is_active)
		if (workspaces.get(i).active_window_id !== ws.active_window_id) workspaces.setProperty(i, "active_window_id", ws.active_window_id)
		return
	    }
	}
	let insertAt = workspaces.count
	for (let i = 0; i < workspaces.count; i++) {
	    if (workspaces.get(i).idx > ws.idx) { insertAt = i; break }
	}
	workspaces.insert(insertAt, ws)
    }

    function normalize(ws) {
	return {
	    id: ws.id,
	    idx: ws.idx,
	    output: ws.output ?? "",
	    name: ws.name ?? "",
	    is_active: !!ws.is_active,
	    active_window_id: ws.active_window_id ?? -1
	}
    }

    function syncAll(newList) {
	// remove ones that no longer exist
	for (let i = workspaces.count - 1; i >= 0; i--) {
	    const id = workspaces.get(i).id
	    if (!newList.some(w => w.id === id)) workspaces.remove(i)
	}
	newList.forEach(upsert)
    }

    property Process eventStream: Process {
	command: ["niri", "msg", "-j", "event-stream"]
	running: true

	stdout: SplitParser {
	    onRead: line => {
		if (!line.trim()) return
		let ev
		try {
		    ev = JSON.parse(line)
		} catch (e) {
		    console.warn("Niri.qml: bad event line", line)
		    return
		}

		if (ev.WorkspacesChanged) {
		    root.syncAll(ev.WorkspacesChanged.workspaces)
		} else if (ev.WorkspaceActivated) {
		    const id = ev.WorkspaceActivated.id
		    let output = null
		    for (let i = 0; i < root.workspaces.count; i++) {
			if (root.workspaces.get(i).id === id) { output = root.workspaces.get(i).output; break }
		    }
		    if (output !== null) {
			for (let i = 0; i < root.workspaces.count; i++) {
			    const ws = root.workspaces.get(i)
			    if (ws.output === output) {
				const active = (ws.id === id)
				if (ws.is_active !== active) root.workspaces.setProperty(i, "is_active", active)
			    }
			}
		    }
		} else if (ev.WorkspaceActiveWindowChanged) {
		    const { workspace_id, active_window_id } = ev.WorkspaceActiveWindowChanged
		    for (let i = 0; i < root.workspaces.count; i++) {
			if (root.workspaces.get(i).id === workspace_id) {
			    root.workspaces.setProperty(i, "active_window_id", active_window_id)
			    break
			}
		    }
		}
	    }
	}

	onExited: (code, status) => {
	    console.warn("Niri.qml: event-stream died, code", code, "— restarting in 1s")
	    restartTimer.start()
	}
    }

    property Timer restartTimer: Timer {
	interval: 1000
	onTriggered: root.eventStream.running = true
    }
}
