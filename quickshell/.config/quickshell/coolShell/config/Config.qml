pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    property alias fonts: adapter.fonts

    FileView {
        path: Quickshell.env("HOME") + "/.config/quickshell/coolShell/config/config.json"
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            id: adapter
            property JsonObject fonts: JsonObject {
                property string display: "Playfair Display"
                property string mono: "JetBrainsMono Nerd Font"
                property JsonObject sizes: JsonObject {
                    property int small: 12
                    property int normal: 15
                    property int large: 22
                }
            }
        }
    }
}
