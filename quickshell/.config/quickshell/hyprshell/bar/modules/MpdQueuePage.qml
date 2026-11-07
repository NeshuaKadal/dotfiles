import QtQuick
import QtQuick.Layouts
import qs.bar.components
import qs.bar.services
import qs.services

Item {
    id: page
    signal navigate(string to)

    implicitWidth: 1400
    implicitHeight: 16
    focus: true

    Component.onCompleted: {
	forceActiveFocus()
	list.currentIndex = Math.max(0, Mpd.currentPos - 1)
	list.positionViewAtIndex(list.currentIndex, ListView.Center)
    }

    function selected() { return Mpd.queue[list.currentIndex] }

    property bool confirmClear: false
    Timer { id: clearTimer; interval: 3000; onTriggered: page.confirmClear = false }

    function clearAll() {
	if (!confirmClear) { confirmClear = true; clearTimer.restart(); return }
	confirmClear = false
	Mpd.clearQueue()
    }

    Keys.onPressed: e => {
	switch (e.key) {
	    case Qt.Key_Escape:
	    case Qt.Key_Backspace: page.navigate("now"); break
	    case Qt.Key_Left:      list.decrementCurrentIndex(); break
	    case Qt.Key_Right:     list.incrementCurrentIndex(); break
	    case Qt.Key_Return:
	    case Qt.Key_Enter:     { const t = page.selected(); if (t) Mpd.playPos(t.pos) } break
	    case Qt.Key_Delete:    { const t = page.selected(); if (t) Mpd.removePos(t.pos) } break
	    case Qt.Key_C: page.clearAll(); break
	    default: return
	}
	e.accepted = true
    }

    RowLayout {
	anchors.fill: parent
	spacing: 8

	BarText {
	    Layout.alignment: Qt.AlignVCenter
	    text: "QUEUE [" + Mpd.queue.length + "] >"
	}

	ListView {
	    id: list
	    Layout.fillWidth: true
	    Layout.fillHeight: true
	    orientation: ListView.Horizontal
	    clip: true
	    spacing: 4
	    model: Mpd.queue
	    onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Contain)

	    delegate: Rectangle {
		id: item
		required property var modelData
		required property int index
		readonly property bool selected: ListView.isCurrentItem
		readonly property bool nowPlaying: modelData.pos === Mpd.currentPos

		height: list.height
		width: label.implicitWidth + 8
		color: selected ? nowPlaying ? Colors.mPrimary : Colors.mOnSurface : "transparent"

		BarText {
		    id: label
		    anchors.centerIn: parent
		    color: item.selected ? page.Colors.mSurface : nowPlaying ? Colors.mPrimary : Colors.mOnSurface
		    text: "[" + item.modelData.pos + "] " + [item.modelData.title, item.modelData.artist].filter(s => s).join(" - ")
		}
		MouseArea {
		    anchors.fill: parent
		    cursorShape: Qt.PointingHandCursor
		    onClicked: { list.currentIndex = item.index; Mpd.playPos(item.modelData.pos) }
		}
	    }
	}
    }
}
