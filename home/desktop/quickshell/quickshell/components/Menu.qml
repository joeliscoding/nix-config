import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "root:/config"

Item {
    id: root

    Layout.alignment: Qt.AlignCenter
    implicitWidth: 24
    implicitHeight: 24

    IconImage {
        id: icon
        source: "root:/assets/nix.svg"
        implicitSize: 24

        layer.enabled: true
        layer.effect: MultiEffect {
            brightness: 1.0
            colorization: 1.0
            colorizationColor: Matugen.colors.text
        }
    }

}
