pragma Singleton

import Quickshell

Singleton {
    id: root

    property var font: ({
	mono: "JetBrainsMono Nerd Font",
	fancy: "Playfair Display",
	icon: "Font Awesome 7 Free Solid",
	size: 13
    })

    property var button: ({
	rounded: true
    })

    property var bar: ({
	radius: 0,
	height: 34,
	alpha: 0.85,
	margins: 6,
	spacing: 6,
	border: 0,
	widgetHeight: 24,
	widgetWidth: 24
    })

    property var wallpaper: ({
	directory: Quickshell.env("HOME") + "/Pictures/Wallpapers"
    })

    property var widgets: ({
    })

    property var screens: ({
	"DP-2": { enabled: true }
    })

    function forScreen(name: string): var {
	return screens[name] ?? { enabled: true };
    }
}
