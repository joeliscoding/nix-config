import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "root:/config"

PanelWindow {
    id: osd

    property var trigger
    property string label: ""
    property string icon: ""
    property int timeVisible: 1800

    visible: false
    exclusiveZone: -1
    anchors.left: true
    margins.left: 10
    implicitWidth: 48
    implicitHeight: 56
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: Appearance.radius
        color: Matugen.colors.background
        border { color: Matugen.colors.accent; width: Appearance.borderWidth }

        ColumnLayout {
            anchors {
                fill: parent
            }
            spacing: 0


            IconImage {
                Layout.alignment: Qt.AlignCenter
                source: osd.icon
                implicitSize: 24

                layer.enabled: true
                layer.effect: MultiEffect {
                    brightness: 1.0
                    colorization: 1.0
                    colorizationColor: Matugen.colors.text
                }
            }

            Text {
                Layout.alignment: Qt.AlignCenter
                text: osd.label
                color: Matugen.colors.text
                font {
                    family: "JetBrainsMono Nerd Font"
                    pixelSize: 14
                }
            }
        }
    }


    Timer {
        id: hideTimer
        interval: osd.timeVisible
        onTriggered: osd.visible = false
    }

    Connections {
        target: osd.trigger
        function onChanged() {
            osd.visible = true
            hideTimer.restart()
        }
    }
}
