import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import qs.config
import qs.services

Item {
    implicitWidth: 400
    implicitHeight: 320

    FolderListModel {
        id: folderModel
        folder: "file://" + Config.wallpaper.directory
        nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp"]
        showDirs: false
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 10

        Text {
            text: "Wallpaper (" + folderModel.count + ")"
            color: Colors.m3onBackground
            font.pixelSize: 15
        }

        GridView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            cellWidth: 110
            cellHeight: 70
            clip: true

            model: folderModel
            delegate: Item {
                width: 100
                height: 60

                Image {
                    anchors.fill: parent
                    source: fileUrl
                    smooth: true
                    asynchronous: true
                }

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.width: WallpaperService.current === filePath ? 2 : 0
                    border.color: Colors.m3primary
                    radius: 4
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: WallpaperService.setWallpaper(filePath)
                }
            }
        }
    }
}
