import QtQuick
import Quickshell
import qs.config

Text {
    font.family: Config.fonts.mono
    font.pixelSize: Config.fonts.size.normal
    color: Config.colors.foreground
    text: {
	if (!sysClock || !sysClock.date) return "";
	const h = sysClock.date.getHours() % 12 || 12;
	const m = sysClock.date.getMinutes();
	const time = h + ":" + (m < 10 ? "0" + m : m);
	const date = Qt.formatDateTime(sysClock.date, "dddd");
	return date + " " + time;
    }
    SystemClock {
	id: sysClock
	precision: SystemClock.Minutes
    }
}
