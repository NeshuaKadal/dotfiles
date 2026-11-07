pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property color mPrimary: store.mPrimary
    readonly property color mOnPrimary: store.mOnPrimary
    readonly property color mSecondary: store.mSecondary
    readonly property color mOnSecondary: store.mOnSecondary
    readonly property color mTertiary: store.mTertiary
    readonly property color mOnTertiary: store.mOnTertiary
    readonly property color mError: store.mError
    readonly property color mOnError: store.mOnError
    readonly property color mSurface: store.mSurface
    readonly property color mOnSurface: store.mOnSurface
    readonly property color mSurfaceVariant: store.mSurfaceVariant
    readonly property color mOnSurfaceVariant: store.mOnSurfaceVariant
    readonly property color mOutline: store.mOutline
    readonly property color mShadow: store.mShadow
    readonly property color mHover: store.mHover
    readonly property color mOnHover: store.mOnHover

    readonly property color black: store.black
    readonly property color red: store.red
    readonly property color orange: store.orange
    readonly property color yellow: store.yellow
    readonly property color green: store.green
    readonly property color cyan: store.cyan
    readonly property color blue: store.blue
    readonly property color magenta: store.magenta
    readonly property color white: store.white

    readonly property color brightBlack: store.brightBlack
    readonly property color brightRed: store.brightRed
    readonly property color brightOrange: store.brightOrange
    readonly property color brightYellow: store.brightYellow
    readonly property color brightGreen: store.brightGreen
    readonly property color brightCyan: store.brightCyan
    readonly property color brightBlue: store.brightBlue
    readonly property color brightMagenta: store.brightMagenta
    readonly property color brightWhite: store.brightWhite

    readonly property color foreground: store.foreground
    readonly property color background: store.background
    readonly property color cursor: store.cursor
    readonly property color cursorText: store.cursorText
    readonly property color selectionFg: store.selectionFg
    readonly property color selectionBg: store.selectionBg

    FileView {
	path: Quickshell.env("HOME") + "/.local/state/quickshell/colors.json"
	watchChanges: true
	onFileChanged: reload()

	adapter: JsonAdapter {
	    id: store
	    property string mPrimary: "#ffb785"
	    property string mOnPrimary: "#502500"
	    property string mSecondary: "#e4bfa8"
	    property string mOnSecondary: "#422b1b"
	    property string mTertiary: "#c9ca94"
	    property string mOnTertiary: "#31320a"
	    property string mError: "#ffb4ab"
	    property string mOnError: "#690005"
	    property string mSurface: "#19120d"
	    property string mOnSurface: "#f0dfd6"
	    property string mSurfaceVariant: "#52443b"
	    property string mOnSurfaceVariant: "#d7c3b7"
	    property string mOutline: "#9f8d83"
	    property string mShadow: "#000000"
	    property string mHover: "#c9ca94"
	    property string mOnHover: "#31320a"

	    property string black: "#19120d"
	    property string red: "#ffb59e"
	    property string orange: "#ffb780"
	    property string yellow: "#f5bc6f"
	    property string green: "#c3cd7c"
	    property string cyan: "#80d4d9"
	    property string blue: "#b4c5ff"
	    property string magenta: "#f5b2e1"
	    property string white: "#f0dfd6"

	    property string brightBlack: "#2a1e16"
	    property string brightRed: "#ffc8b8"
	    property string brightOrange: "#ffc59a"
	    property string brightYellow: "#f7c787"
	    property string brightGreen: "#cbd48e"
	    property string brightCyan: "#94dbdf"
	    property string brightBlue: "#ced9ff"
	    property string brightMagenta: "#f8c9ea"
	    property string brightWhite: "#f7eee9"
	}
    }
}
