import Quickshell
import QtQuick
import "root:/components"
import "root:/config"
import "root:/services"

Scope {
    OSD {
        trigger: Brightness
        label: Brightness.brightnessString
        icon: qsTr("root:/assets/brightness/%1.svg").arg(Brightness.brightnessIcon)
    }

    //qsTr("root:/assets/brightness/%1.svg").arg(Brightness.brightnessIcon)
    //Brightness.brightnessString
    //Brightness
}
