// modules/panel/Screens.qml
pragma Singleton

import Quickshell

Singleton {
    readonly property var list: [
        { label: "Home", source: Qt.resolvedUrl("screens/Home.qml") },
        { label: "Music", source: Qt.resolvedUrl("screens/Music.qml") },
        { label: "Clock", source: Qt.resolvedUrl("screens/Clock.qml") },
        { label: "Volume", source: Qt.resolvedUrl("screens/Volume.qml") },
        { label: "System", source: Qt.resolvedUrl("screens/System.qml") },
        { label: "Apps", source: Qt.resolvedUrl("screens/Apps.qml") },
    ]
}
