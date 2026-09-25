import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "root:/config"

Item {
    id: root

    Layout.alignment: Qt.AlignCenter
    implicitWidth: 24
    implicitHeight: workspaceColumn.implicitHeight

    ColumnLayout {
        id: workspaceColumn
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 4

        Repeater {
            model: Hyprland.workspaces

            Item {
                id: workspaceItem
                required property HyprlandWorkspace modelData

                Layout.alignment: Qt.AlignHCenter
                implicitWidth: 24
                implicitHeight: 24

                Rectangle {
                    anchors.centerIn: parent
                    width: 24
                    height: 24
                    radius: 6
                    color: "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: workspaceItem.modelData.id
                        color: workspaceItem.modelData.focused ? Matugen.colors.accent : Matugen.colors.text
                        font {
                            pixelSize: 14
                            weight: Font.Medium
                            family: Appearance.fontFamily
                        }
                    }
                }
            }
        }
    }
}
