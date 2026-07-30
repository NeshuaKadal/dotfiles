import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import qs.config
import qs.services
import qs.components

Row {
    id: root
    spacing: 4

    Repeater {
        model: SystemTray.items

        delegate: Item {
            id: trayIcon
            required property SystemTrayItem modelData

            implicitWidth: 20
            implicitHeight: 20

            QsMenuOpener {
                id: opener
                menu: trayIcon.modelData.menu
            }

            Rectangle {
                anchors.fill: parent
                radius: width / 2
                color: ColorUtils.withAlpha(
                    Config.colors.foreground,
                    mouseArea.pressed ? 0.16 : (mouseArea.containsMouse ? 0.08 : 0)
                )
                Behavior on color { ColorAnimation { duration: 100 } }
            }

            Image {
                anchors.centerIn: parent
                width: 16
                height: 16
                sourceSize: Qt.size(16, 16)
                source: trayIcon.modelData.icon
                smooth: true
            }

	    MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		acceptedButtons: Qt.LeftButton | Qt.RightButton
		onClicked: mouse => {
		    if (trayIcon.modelData.hasMenu) {
			trayMenu.menuShown = !trayMenu.menuShown;
		    } else {
			trayIcon.modelData.activate();
		    }
		}
	    }

            QsMenu {
                id: trayMenu
                opener: opener
            }
        }
    }
}
