import QtQuick

Item {
    id: root
    property string source: ""
    property int targetWidth: 3440
    property int duration: 500

    property bool showA: true
    property Image pending: null

    onSourceChanged: {
        const incoming = showA ? b : a
        pending = incoming
        incoming.source = source
        // same image already loaded in that layer: no status change will fire, swap now
        if (incoming.status === Image.Ready) showA = (incoming === a)
    }

    Image {
        id: a
        anchors.fill: parent
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
        sourceSize.width: root.targetWidth
        opacity: root.showA ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: root.duration; easing.type: Easing.InOutQuad } }
        onStatusChanged: if (status === Image.Ready && root.pending === a) root.showA = true
    }

    Image {
        id: b
        anchors.fill: parent
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
        sourceSize.width: root.targetWidth
        opacity: root.showA ? 0 : 1
        Behavior on opacity { NumberAnimation { duration: root.duration; easing.type: Easing.InOutQuad } }
        onStatusChanged: if (status === Image.Ready && root.pending === b) root.showA = false
    }
}
