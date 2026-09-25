import Quickshell
import QtQuick
import QtQuick.Layouts
import "root:/config"
import "root:/components"

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData
            implicitWidth: 48
            color: "transparent"

            anchors {
                top: true
                left: true
                bottom: true
            }

            margins {
                left: 10
                top: 10
                bottom: 10
            }

            Rectangle {
                id: bar
                anchors.fill: parent
                radius: Appearance.radius
                color: Matugen.colors.background
                border.color: Matugen.colors.border
                border.width: Appearance.borderWidth
            }

            // top
            ColumnLayout {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: 10
                }
                spacing: 16

                Menu {}

                Divider {}

                Workspaces {}
            }

            // center
            ColumnLayout {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                spacing: 16

                Clock {}
            }

            ColumnLayout {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: 10
                }
                spacing: 16

                Network {}

                Battery {}
            }
        }
    }
}
