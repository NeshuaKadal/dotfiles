import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.bar.components
import qs.bar.services
import qs.services

BarModule {
    name: "launcher"

    GlobalShortcut {
        appid: "quickshell"
        name: "launcher"
        onPressed: BarState.toggle("launcher", true)
    }
    IpcHandler {
        target: "launcher"
        function toggle(): void { BarState.toggle("launcher", true) }
    }

    view: Component {
        Item {
            id: launcher
            implicitWidth: 1000
            implicitHeight: 16

            readonly property var results: {
                const q = input.text.toLowerCase()
                return Array.from(DesktopEntries.applications.values)
                    .filter(a => a.name.toLowerCase().includes(q))
                    .sort((a, b) => {
                        const as = a.name.toLowerCase().startsWith(q) ? 0 : 1
                        const bs = b.name.toLowerCase().startsWith(q) ? 0 : 1
                        return as - bs || a.name.localeCompare(b.name)
                    })
            }

            function launch() {
                const e = results[list.currentIndex]
                BarState.close()
                if (e) e.execute()
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 6
                spacing: 12

                TextInput {
                    id: input
                    Layout.preferredWidth: 240
                    color: Colors.mOnSurface
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 12
                    font.weight: 700
		    font.capitalization: Font.AllUppercase
                    Component.onCompleted: forceActiveFocus()
                    onTextChanged: list.currentIndex = 0

                    Keys.onEscapePressed: BarState.close()
                    Keys.onReturnPressed: launcher.launch()
                    Keys.onTabPressed:   list.incrementCurrentIndex()
                    Keys.onRightPressed: list.incrementCurrentIndex()
                    Keys.onLeftPressed:  list.decrementCurrentIndex()
                }

                ListView {
                    id: list
		    Layout.fillWidth: true
		    height: 16
		    orientation: ListView.Horizontal
		    clip: true
		    spacing: 4
		    model: launcher.results

		    delegate: Rectangle {
			id: item
			required property var modelData
			readonly property bool selected: ListView.isCurrentItem

			height: list.height
			width: label.implicitWidth + 12
			color: selected ? Colors.mSecondary : "transparent"

			BarText {
			    id: label
			    anchors.centerIn: parent
			    text: item.modelData.name
			    font.capitalization: Font.AllUppercase
			    color: item.selected ? Colors.mSurface : Colors.mOnSurface
			}
		    }
		}
	    }
	}
    }
}
