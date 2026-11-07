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
	return if format === 12 ? format12(clock.date) : Qt.formatTime(clock.date, format || "hh:mm")
    }

    function date(format) {
	return Qt.formatDate(clock.date, format || "dd-MM-yy")
    }

    function format12(date) {
	let h = date.getHours() % 12         // Get the 24 hour and fold it into 12
	if (h === 0) h = 12                  // If the hour is 0 (12am), set it to 12
	const hh = h < 10 ? "0" + h : "" + h // If the hour is a single digit, add a 0 before
	const m = date.getMinutes()          // Get the minute
	const mm = m < 10 ? "0" + m : "" + m // If the minute is a single digit, add a 0 before
	return hh + ":" + mm                 // Put it all together
    }
}
