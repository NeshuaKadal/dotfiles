pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    property alias fonts: adapter.fonts
    property alias notifications: adapter.notifications
    property alias opacities: adapter.opacities
    property alias player: adapter.player
    property alias wallpaper: adapter.wallpaper

    FileView {
	path: Quickshell.env("HOME") + "/.config/quickshell/newShell/config/config.json"
	watchChanges: true
	onFileChanged: reload()

	JsonAdapter {
	    id: adapter

	    property JsonObject fonts: JsonObject {
		property string mono: "JetBrainsMono Nerd Font"

		property JsonObject icons: JsonObject {
		    property string solid: "Font Awesome 7 Free Solid"
		    property string regular: "Font Awesome 7 Free"
		}
		property JsonObject sizes: JsonObject {
		    property int tiny: 8
		    property int small: 10
		    property int normal: 12
		    property int medium: 14
		    property int large: 16
		}
	    }
	    property JsonObject notifications: JsonObject {
		property int timeout: 5000
	    }
	    property JsonObject opacities: JsonObject {
		property int surface: 85
	    }
	    property JsonObject player: JsonObject {
		property var allowedSources: ["mpd", "mpd-mpris"]
	    }
	    property JsonObject wallpaper: JsonObject {
		property string directory: Quickshell.env("HOME") + "/Pictures/Wallpapers"
	    }
	}
    }
}
