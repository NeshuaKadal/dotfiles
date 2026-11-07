import QtQuick
import Quickshell
import Quickshell.Io
import qs.services

import "./modules/bar"
import "./modules/background"

ShellRoot {
    Variants {
	model: Screens.screens

	Bar {
	    required property var modelData
	    screen: modelData
	}
    }

    Wallpaper {}

    Variants {
	model: Screens.screens

	Widgets {
	    required property var modelData
	    screen: modelData
	}
    }
}
