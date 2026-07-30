import QtQuick
import Quickshell
import qs.config
import qs.services

Text {
    id: root
    color: Colors.m3onBackground
    font.family: Config.fonts.mono
    font.pixelSize: Config.fonts.sizes.normal

    text: {
	if (!clock || !clock.date) return "";
	const h = clock.date.getHours() % 12 || 12;
	const m = clock.date.getMinutes();
	const time = h + ":" + (m < 10 ? "0" + m : m);
	return time;
    }
    SystemClock {
	id: clock
	precision: SystemClock.Minutes
    }
}
