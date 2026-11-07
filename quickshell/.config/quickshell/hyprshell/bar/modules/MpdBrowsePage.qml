import QtQuick
import QtQuick.Layouts
import qs.bar.components
import qs.bar.services
import qs.services

Item {
    id: page
    signal navigate(string to)

    readonly property color fg: Qt.rgba(222/255, 222/255, 222/255, 1)
    readonly property color dark: Qt.rgba(14/255, 14/255, 14/255, 1)

    implicitWidth: 1400
    implicitHeight: 16

    property int level: 0            // 0 artists, 1 albums, 2 songs
    property string artist: ""
    property string album: ""        // "" = every album
    property string notice: ""

    readonly property var items: {
        const q = input.text.toLowerCase()
        let all
        if (level === 0)
            all = Mpd.artists.map(a => ({ label: a, value: a }))
        else if (level === 1)
            all = [{ label: "[ ALL ]", value: "" }].concat(Mpd.albums.map(a => ({ label: a, value: a })))
        else
            all = Mpd.songs.map(s => ({ label: (s.track ? s.track + "  " : "") + s.title, value: s.file }))
        if (!q) return all
        return all.filter(i => (level === 1 && i.value === "") || i.label.toLowerCase().includes(q))
    }

    readonly property string crumb: level === 0 ? "ARTISTS"
        : level === 1 ? artist
        : artist + " / " + (album || "ALL")

    function enter(item) {
        if (!item) return
        input.text = ""
        list.currentIndex = 0
        if (level === 0) { artist = item.value; album = ""; level = 1; Mpd.loadAlbums(artist) }
        else if (level === 1) { album = item.value; level = 2; Mpd.loadSongs(artist, album) }
        else act(item, true)
    }

    function back() {
        input.text = ""
        list.currentIndex = 0
        if (level > 0) level--
        else navigate("now")
    }

    // replace = true: clear the queue and play; false: append
    function act(item, replace) {
        if (!item) return
        if (level === 2) Mpd.addFile(item.value, replace)
        else if (level === 1)
            Mpd.addMatch(item.value ? ["artist", artist, "album", item.value] : ["artist", artist], replace)
        else Mpd.addMatch(["artist", item.value], replace)
        notice = replace ? "PLAYING" : "ADDED"
        noticeTimer.restart()
    }

    Timer { id: noticeTimer; interval: 1500; onTriggered: page.notice = "" }

    Component.onCompleted: { input.forceActiveFocus(); Mpd.loadArtists() }

    RowLayout {
        anchors.fill: parent
        spacing: 8

        TextInput {
            id: input
            Layout.preferredWidth: 140
            Layout.alignment: Qt.AlignVCenter
            color: Colors.mOnSurface
            clip: true
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 12
            font.weight: 700
            onTextChanged: list.currentIndex = 0

            Keys.onPressed: e => {
                const sel = page.items[list.currentIndex]
                if (e.key === Qt.Key_Escape) page.back()
                else if (e.key === Qt.Key_Left) list.decrementCurrentIndex()
                else if (e.key === Qt.Key_Right) list.incrementCurrentIndex()
                else if (e.key === Qt.Key_Return || e.key === Qt.Key_Enter) {
                    if (e.modifiers & Qt.ControlModifier) page.act(sel, true)
                    else if (e.modifiers & Qt.ShiftModifier) page.act(sel, false)
                    else page.enter(sel)
                }
                else if (e.key === Qt.Key_Backspace && input.text === "") page.back()
                else return
                e.accepted = true
            }
        }

        BarText {
            Layout.alignment: Qt.AlignVCenter
            Layout.maximumWidth: 280
            elide: Text.ElideRight
            font.capitalization: Font.AllUppercase
	    text: page.crumb + " >"
	    color: Colors.mSecondary
        }

        ListView {
            id: list
            Layout.fillWidth: true
            Layout.fillHeight: true
            orientation: ListView.Horizontal
            clip: true
            spacing: 4
            model: page.items
            onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Contain)

            WheelHandler {
                onWheel: e => {
                    const dx = e.angleDelta.y || e.angleDelta.x
                    list.contentX = Math.max(0, Math.min(list.contentWidth - list.width, list.contentX - dx))
                }
            }

            delegate: Rectangle {
                id: item
                required property var modelData
                required property int index
                readonly property bool selected: ListView.isCurrentItem

                height: list.height
                width: label.implicitWidth + 12
                color: selected ? Colors.mSecondary : "transparent"

                BarText {
                    id: label
                    anchors.centerIn: parent
                    color: item.selected ? Colors.mSurface : Colors.mOnSurface
                    text: item.modelData.label
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: { list.currentIndex = item.index; page.enter(item.modelData) }
                }
            }
        }

        BarText {
            Layout.alignment: Qt.AlignVCenter
            text: page.notice || "[RETURN] OPEN  [SHIFT + RETURN] ADD  [CTRL + RETURN] PLAY"
        }
    }
}
