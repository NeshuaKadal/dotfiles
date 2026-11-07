pragma Singleton
import QtQuick

//---------- GENERAL ----------

QtObject {
    readonly property QtObject rounding: QtObject {
	readonly property int extraSmall: 8
	readonly property int small: 12
	readonly property int medium: 16
	readonly property int large: 24
	readonly property int extraLarge: 32
	readonly property real full: 999999
    }

    readonly property QtObject spacing: QtObject {
	readonly property int extraSmall: 8
	readonly property int small: 12
	readonly property int medium: 16
	readonly property int large: 24
	readonly property int extraLarge: 32
    }

    readonly property QtObject padding: QtObject {
	readonly property int extraSmall: 8
	readonly property int small: 12
	readonly property int medium: 16
	readonly property int large: 24
	readonly property int extraLarge: 32
    }

    readonly property QtObject fontSize: QtObject {
	readonly property int extraSmall: 10
	readonly property int small: 12
	readonly property int normal: 16
	readonly property int large: 24
	readonly property int extraLarge: 32
    }

    readonly property QtObject motion: QtObject {
	readonly property QtObject duration: QtObject {
	    readonly property int expressiveFastSpatial:    350
	    readonly property int expressiveDefaultSpatial: 500
	    readonly property int expressiveSlowSpatial:    650
	    readonly property int expressiveFastEffects:    150
	    readonly property int expressiveDefaultEffects: 200
	    readonly property int expressiveSlowEffects:    300
	    readonly property int standardFastSpatial:      350
	    readonly property int standardDefaultSpatial:   500
	    readonly property int standardSlowSpatial:      750
	    readonly property int standardFastEffects:      150
	    readonly property int standardDefaultEffects:   200
	    readonly property int standardSlowEffects:      300
	}

	readonly property QtObject curve: QtObject {
	    readonly property var expressiveFastSpatial:    [0.42, 1.67, 0.21, 0.90, 1.0, 1.0]
	    readonly property var expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1.00, 1.0, 1.0]
	    readonly property var expressiveSlowSpatial:    [0.39, 1.29, 0.35, 0.98, 1.0, 1.0]
	    readonly property var expressiveFastEffects:    [0.31, 0.94, 0.34, 1.00, 1.0, 1.0]
	    readonly property var expressiveDefaultEffects: [0.34, 0.80, 0.34, 1.00, 1.0, 1.0]
	    readonly property var expressiveSlowEffects:    [0.34, 0.88, 0.34, 1.00, 1.0, 1.0]
	    readonly property var standardFastSpatial:      [0.27, 1.06, 0.18, 1.00, 1.0, 1.0]
	    readonly property var standardDefaultSpatial:   [0.27, 1.06, 0.18, 1.00, 1.0, 1.0]
	    readonly property var standardSlowSpatial:      [0.27, 1.06, 0.18, 1.00, 1.0, 1.0]
	    readonly property var standardFastEffects:      [0.31, 0.94, 0.34, 1.00, 1.0, 1.0]
	    readonly property var standardDefaultEffects:   [0.34, 0.80, 0.34, 1.00, 1.0, 1.0]
	    readonly property var standardSlowEffects:      [0.34, 0.88, 0.34, 1.00, 1.0, 1.0]
	}
    }

    //---------- MODULE SPECIFIC ----------

    // buttons
    readonly property QtObject button: QtObject {
	readonly property var shape: ({
	    xs: { square: rounding.extraSmall,  pressed: rounding.extraSmall },
	    s:  { square: rounding.medium,  pressed: rounding.small },
	    m:  { square: rounding.large,   pressed: rounding.medium },
	    l:  { square: rounding.extraLarge, pressed: rounding.large },
	    xl: { square: rounding.extraLarge, pressed: rounding.large }
	})
	readonly property var size: ({
	    xs: { height: 24,  padH: padding.extraSmall, font: fontSize.extraSmall },
	    s:  { height: 30,  padH: padding.small, font: fontSize.small },
	    m:  { height: 36,  padH: padding.medium, font: fontSize.normal },
	    l:  { height: 42,  padH: padding.large, font: fontSize.large },
	    xl: { height: 48, padH: padding.extraLarge, font: fontSize.extraLarge }
	})
    }
}
