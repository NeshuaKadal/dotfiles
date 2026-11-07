pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    SystemClock {
	id: clock
	precision: SystemClock.Minutes
    }

    function time(format) {
	return Qt.formatTime(clock.date, format || "hh:mm")
    }

    function date(format) {
	return Qt.formatDate(clock.date, format || "dd-MM-yy")
    }
}
