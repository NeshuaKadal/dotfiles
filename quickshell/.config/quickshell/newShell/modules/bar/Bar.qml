import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

PanelWindow {
    id: bar
    WlrLayershell.namespace: "quickshell:bar"
    anchors { top: true }
    color: "transparent"
    BackgroundEffect.blurRegion: Region { item: contentRect; radius: contentRect.radius }

    WlrLayershell.keyboardFocus: registry[UiState.active]?.isMenu ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
    screen: Quickshell.screens.find(s => s.name === NiriService.focusedOutput) ?? Quickshell.screens[0]

    implicitWidth: contentLoader.item ? contentLoader.item.implicitWidth : 800
    implicitHeight: contentLoader.item ? contentLoader.item.implicitHeight : 40
    margins.top: 8
    margins.left: screen ? (screen.width - implicitWidth) / 2 : 0

    Behavior on implicitWidth { SmoothedAnimation { duration: 64; easing.type: Easing.OutQuint } }
    Behavior on implicitHeight { SmoothedAnimation { duration: 64; easing.type: Easing.OutQuint } }

    Rectangle {
	id: contentRect
	anchors.fill: parent
	radius: Math.min(height / 2, 32)
	color: ColorUtils.withAlpha(Colors.m3background, 0.85)
	focus: registry[UiState.active]?.isMenu ?? false
	Keys.onEscapePressed: UiState.close()

	Loader {
	    id: contentLoader
	    anchors.fill: parent
	    sourceComponent: registry[UiState.active]?.component ?? barComp
	}
    }

    readonly property var registry: ({
	"wallpaper": { component: wallpaperComp, isMenu: true },
	"volume": { component: volumeComp, isMenu: true },
	"volume-osd": { component: volumeOsdComp, isMenu: false },
	"source-volume-osd": { component: sourceVolumeOsdComp, isMenu: false },
	"notifications": { component: notifComp, isMenu: true },
	"notification-osd": { component: notifOsdComp, isMenu: false },
	"player-osd": { component: playerOsdComp, isMenu: false },
	"player": { component: playerComp, isMenu: true }
    })

    Component.onCompleted: Controllers.forceInit()
    Component { id: wallpaperComp; WallpaperPickerExpanded {} }
    Component { id: barComp; BarRow { output: NiriService.focusedOutput } }
    Component { id: volumeComp; VolumeExpanded {} }
    Component { id: volumeOsdComp; VolumeOsdExpanded {} }
    Component { id: sourceVolumeOsdComp; SourceVolumeOsdExpanded {} }
    Component { id: notifComp; NotificationCenterExpanded {} }
    Component { id: notifOsdComp; NotificationOsdExpanded {} }
    Component { id: playerComp; PlayerExpanded {} }
    Component { id: playerOsdComp; PlayerOsdExpanded {} }
}
