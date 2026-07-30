pragma Singleton
import QtQuick

QtObject {
    function withAlpha(hex, alpha) {
        const c = Qt.color(hex);
        return Qt.rgba(c.r, c.g, c.b, alpha);
    }
}
