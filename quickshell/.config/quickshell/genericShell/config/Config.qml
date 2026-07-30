pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    property alias colors: adapter.colors
    property alias fonts: adapter.fonts
    property alias icons: adapter.icons
    property alias notifications: adapter.notifications
    property alias opacities: adapter.opacities
    property alias toggles: adapter.toggles
    property alias workspaceNames: adapter.workspaceNames

    FileView {
        path: Quickshell.env("HOME") + "/.config/quickshell/shell/config/config.json"
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            id: adapter

            property JsonObject colors: JsonObject {
                property string accent: "#723E3F"
                property string background: "#242020"
                property string foreground: "#E9E0E5"
            }

            property JsonObject fonts: JsonObject {
                property string sans: "Test Untitled Sans"
                property string serif: "Test Untitled Serif"
                property string mono: "JetBrainsMono Nerd Font"
                property string propo: "JetBrainsMono Nerd Font Propo"

		property JsonObject size: JsonObject {
		    property int tiny: 10
		    property int small: 12
		    property int normal: 14
		    property int medium: 16
		    property int large: 18
		    property int icon: medium
		}
	    }

            property JsonObject icons: JsonObject {
                property string solid: "Font Awesome 7 Free Solid"
                property string regular: "Font Awesome 7 Free"
            }

	    property JsonObject notifications: JsonObject {
		property int timeout: 5000
	    }

	    property JsonObject opacities: JsonObject {
		property real background: 0.85
		property real muted: 0.2
		property real half: 0.5
	    }

            property JsonObject toggles: JsonObject {
                property bool showWorkspaceIndexes: true
            }

            property var workspaceNames: ({
		"1": "I",
		"2": "II",
		"3": "III",
		"4": "IV",
		"5": "V",
		"6": "VI",
		"7": "VII",
		"8": "VIII",
		"9": "IX",
		"10": "X"
            })
        }
    }
}
