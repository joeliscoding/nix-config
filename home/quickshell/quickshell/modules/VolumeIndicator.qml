import Quickshell
import QtQuick
import "root:/components"
import "root:/config"
import "root:/services"

Scope {
    OSD {
        trigger: Pipewire
        label: Pipewire.sinkVolumeString
        icon: qsTr("root:/assets/volume/%1.svg").arg(Pipewire.sinkIcon)
    }
}
