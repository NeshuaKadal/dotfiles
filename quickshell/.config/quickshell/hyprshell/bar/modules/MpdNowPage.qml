import QtQuick
import qs.bar.components
import qs.bar.services

Row {
    id: page
    signal navigate(string to)

    spacing: 6
    leftPadding: 6
    focus: true
    Component.onCompleted: forceActiveFocus()

    Keys.onPressed: e => {
        switch (e.key) {
        case Qt.Key_Escape: BarState.close(); break
        case Qt.Key_Space:  Mpd.toggle(); break
        case Qt.Key_Left:   Mpd.prev(); break
        case Qt.Key_Right:  Mpd.next(); break
        case Qt.Key_S:      Mpd.shuffle(); break
        case Qt.Key_Q:      page.navigate("queue"); break
        case Qt.Key_B:      page.navigate("browse"); break
        default: return
        }
        e.accepted = true
    }

    Item {
        anchors.verticalCenter: parent.verticalCenter
        width: 12
        height: 12
        Image {
            id: art
            anchors.fill: parent
            source: Mpd.artUrl
            sourceSize: Qt.size(24, 24)
            fillMode: Image.PreserveAspectCrop
            visible: status === Image.Ready
        }
        BarText {
            anchors.centerIn: parent
            visible: !art.visible
            text: "󰎆"
            font.pixelSize: 10
        }
    }

    BarText {
        anchors.verticalCenter: parent.verticalCenter
        width: Math.min(implicitWidth, 520)
        elide: Text.ElideRight
        text: !Mpd.connected ? "MPD OFFLINE"
            : Mpd.title ? [Mpd.title, Mpd.artist].filter(s => s).join(" - ")
            : "NOTHING PLAYING"
    }

    Row {
        BarButton { active: Mpd.random; onClicked: Mpd.shuffle(); BarText { text: "" } implicitWidth: 16 }
        BarButton { onClicked: Mpd.prev();   BarText { text: "" } implicitWidth: 16 }
        BarButton { onClicked: Mpd.toggle(); BarText { text: Mpd.playing ? "" : "" } implicitWidth: 16 }
        BarButton { onClicked: Mpd.next();   BarText { text: "" } implicitWidth: 16 }
    }

    Row {
        BarButton { onClicked: page.navigate("queue");  BarText { text: "󰲸" } }
        BarButton { onClicked: page.navigate("browse"); BarText { text: "󱍙" } }
    }
}
