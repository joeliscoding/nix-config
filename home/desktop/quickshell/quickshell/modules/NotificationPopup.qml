import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "root:/config"
import "root:/services"

Variants {
    model: Notifications.notifications.values

    PanelWindow {
        required property var modelData
        property var notification: modelData

        anchors { top: true; right: true }
        margins { top: 10; right: 10 }
        implicitWidth: 320
        implicitHeight: 80
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: Appearance.radius
            color: Matugen.colors.background
            border.color: Matugen.colors.border
            border.width: Appearance.borderWidth

            GridLayout {
                anchors.fill: parent
                anchors.margins: 10
                columns: 2
                rows: 2
                columnSpacing: 10

                Image {
                    id: notificationImage
                    source: notification.image
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: notificationImage.implicitHeight * (Layout.preferredWidth / notificationImage.implicitWidth)
                    Layout.rowSpan: 2
                }
                Text {
                    text: notification.summary
                    color: Matugen.colors.text
                    font {
                        bold: true
                        family: Appearance.fontFamily
                    }
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                    Layout.preferredHeight: 10
                }
                Text {
                    text: notification.body
                    color: Matugen.colors.text
                    font.family: Appearance.fontFamily
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                    maximumLineCount: 2
                    Layout.fillWidth: true
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: notification.dismiss()
            }
        }

        // Auto-dismiss after 5s.
        Timer {
            interval: 5000
            running: true
            onTriggered: notification.dismiss()
        }
    }
}
