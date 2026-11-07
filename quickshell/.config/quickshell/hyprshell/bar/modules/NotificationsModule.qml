import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import qs.bar.components
import qs.bar.services

BarModule {
    id: mod
    name: "notification"

    readonly property var n: Notifs.history[0] ?? null

    function durationFor(n) {
        if (mod.n.urgency === NotificationUrgency.Critical) return 10000
        return mod.n.expireTimeout > 0 ? Math.max(3000, Math.min(10000, mod.n.expireTimeout * 1000)) : 5000
    }

    function iconSource(name) {
        if (!name) return ""
        return name.startsWith("/") || name.startsWith("file:") ? name : Quickshell.iconPath(name, true)
    }

    Connections {
        target: Notifs
        function onArrived(n) {
            if (!Notifs.dnd) return BarState.flash("notification", mod.durationFor(n))
        }
    }

    IpcHandler {
	target: "notifications"
	function toggleDnd(): void { Notifs.dnd = !Notifs.dnd }
	function clear(): void { Notifs.dismissAll() }
    }

    view: Component {
        Rectangle {
            id: card
            readonly property var n: mod.n
            readonly property bool critical: n?.urgency === NotificationUrgency.Critical
            readonly property color fg: critical ? Qt.rgba(14/255, 14/255, 14/255, 1) : Qt.rgba(222/255, 222/255, 222/255, 1)

            implicitHeight: 16
            implicitWidth: row.implicitWidth + 12
            color: critical ? Qt.rgba(222/255, 222/255, 222/255, 1) : "transparent"

            Row {
                id: row
                anchors.centerIn: parent
                spacing: 6

                Item {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 12; height: 12

                    Image {
                        id: img
                        anchors.fill: parent
                        source: card.n ? (card.n.image || mod.iconSource(card.n.appIcon)) : ""
                        sourceSize: Qt.size(24, 24)
                        fillMode: Image.PreserveAspectCrop
                        visible: status === Image.Ready
                    }
                    BarText {
                        anchors.centerIn: parent
                        visible: !img.visible
                        text: "󰂚"
                        font.pixelSize: 10
                        color: card.fg
                    }
                }

                BarText {
                    anchors.verticalCenter: parent.verticalCenter
                    width: Math.min(implicitWidth, 600)
                    elide: Text.ElideRight
                    textFormat: Text.PlainText      // bodies can carry markup
                    color: card.fg
                    text: {
                        const n = card.n
                        if (!n) return ""
                        const body = (n.body ?? "").replace(/\n/g, " ")
                        return [n.summary || n.appName, body].filter(s => s).join(" - ")
                    }
                }
            }

	    MouseArea {
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
		acceptedButtons: Qt.LeftButton | Qt.RightButton
		onClicked: {
		    if (mouse.button === Qt.RightButton) {
			BarState.close()
		    }
		}
	    }
	}
    }
}
