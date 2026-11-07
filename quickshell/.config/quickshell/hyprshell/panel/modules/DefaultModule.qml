import QtQuick
import qs.components
import qs.services

BarModule {
    name: "default"
    view: Component {
	BarText { text: Time.time(12) }
    }
}
