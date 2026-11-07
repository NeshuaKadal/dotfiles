import QtQuick
import Quickshell
import Quickshell.Io

import "./bar"
import "./lock"
import "./wallpaper"
import "./panel"

ShellRoot {
    Variants {
	model: Quickshell.screens
	Bar {
	    required property var modelData
	    screen: modelData
	}
    }
    Wallpaper {}
    Lock {}
	//    Panel {
	// screen: Quickshell.screens
	//    }
}
