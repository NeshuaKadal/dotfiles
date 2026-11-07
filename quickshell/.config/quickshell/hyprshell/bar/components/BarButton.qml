import QtQuick

Rectangle {
    id: btn
    property bool active: false
    signal clicked()
    default property alias content: holder.data

    implicitHeight: 16
    implicitWidth: Math.max(holder.width + 8, 16)
    color: Qt.rgba(1, 1, 1, ma.pressed ? 0.10 : (ma.containsMouse || active) ? 0.15 : 0)
    Behavior on color { ColorAnimation { duration: 80 } }

    Item {
        id: holder
        anchors.centerIn: parent
        width: childrenRect.width
        height: childrenRect.height
    }
    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: btn.clicked()
    }
}
