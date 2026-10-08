import QtQuick
import QtQuick.Layouts
import "root:/config"
import "root:/data"

Item {
    id: root

    Layout.alignment: Qt.AlignCenter
    implicitWidth: 30
    implicitHeight: 50

    Text {
        id: clockText
        anchors.centerIn: parent
        text: Time.time
        color: Matugen.colors.text
        font {
            pixelSize: 14
            weight: Font.Medium
            family: Appearance.fontFamily
        }
        horizontalAlignment: Text.AlginHCenter
    }
}
