import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "root:/config"
import "root:/services"

Item {
    id: root

    Layout.alignment: Qt.AlignCenter
    implicitWidth: 24
    implicitHeight: 24

    IconImage {
        id: icon
        anchors.centerIn: parent
        source: qsTr("root:/assets/network/%1.svg").arg(Networking.getIcon())
        implicitSize: 24

        layer.enabled: true
        layer.effect: MultiEffect {
            brightness: 1.0
            colorization: 1.0
            colorizationColor: Matugen.colors.text
        }
    }

}
