import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services

Item {
    readonly property var latest: NotificationService.history[0] ?? null

    implicitWidth: 360
    implicitHeight: 50

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 14
        anchors.rightMargin: 14
        spacing: 10

        Image {
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            Layout.alignment: Qt.AlignVCenter
            fillMode: Image.PreserveAspectFit
            visible: source.toString() !== ""
            source: latest ? (latest.image || "") : ""
        }

        Text {
            visible: !(latest && latest.image)
            text: ""
            color: Colors.m3primary
	    font.pixelSize: Config.fonts.sizes.normal
	    font.family: Config.fonts.mono
	}

	ColumnLayout {
	    Layout.fillWidth: true
	    spacing: 2
	    Text {
		Layout.fillWidth: true
		text: latest ? latest.summary : ""
		color: Colors.m3onBackground
		font.pixelSize: Config.fonts.sizes.normal
		font.family: Config.fonts.mono
		elide: Text.ElideRight
	    }
	    Text {
		Layout.fillWidth: true
		visible: text !== ""
		text: latest ? latest.body : ""
		color: Colors.m3onBackground
		font.pixelSize: Config.fonts.sizes.small
		font.family: Config.fonts.mono
		elide: Text.ElideRight
	    }
	}
    }
    MouseArea {
        anchors.fill: parent
        onClicked: UiState.request("notifications")
    }
}
