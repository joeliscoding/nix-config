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

    visible: UPower.isPresent

    IconImage {
        id: icon
        anchors.centerIn: parent
        source: qsTr("root:/assets/battery/%1.svg").arg(UPower.getIcon())
        implicitSize: 30

        layer.enabled: true
        layer.effect: MultiEffect {
            brightness: 1.0
            colorization: 1.0
            colorizationColor: UPower.charging ? Matugen.colors.accent : Matugen.colors.text
        }
    }

    Text {
        id: batteryText

	    anchors.centerIn: icon
		anchors.horizontalCenterOffset: -1

        text: UPower.getPercentage()
        color: Matugen.colors.background
        font {
            pixelSize: 10
            weight: Font.Medium
            family: Appearance.fontFamily
        }
    }
}
