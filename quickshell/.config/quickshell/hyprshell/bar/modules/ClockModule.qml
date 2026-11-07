import QtQuick
import qs.bar.components
import qs.bar.services

BarModule {
    name: "clock"
    view: Component {
        BarButton {
            onClicked: BarState.toggle("menu")
            BarText { text: Time.time(12) }
        }
    }
}
