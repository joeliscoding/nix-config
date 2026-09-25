// services/Brightness.qml
pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    // adjust to your device: `brightnessctl -l` to list, or leave auto-detect below
    property string device: ""

    readonly property int max: maxFile.text() ? parseInt(maxFile.text()) : 0
    readonly property int current: curFile.text() ? parseInt(curFile.text()) : 0
    readonly property real brightness: max > 0 ? current / max : 0

    signal changed()

    readonly property string brightnessIcon: {
        if (brightness > 0.66) return "brightness-high";
        if (brightness > 0.33) return "brightness-medium";
        return "brightness-low";
    }

    readonly property string brightnessString: {
        return Math.round(brightness * 100) + "%"
    }

    // auto-detect the first backlight device once at startup
    Process {
        running: true
        command: ["sh", "-c", "ls /sys/class/backlight | head -n1"]
        stdout: StdioCollector {
            onStreamFinished: root.device = this.text.trim()
        }
    }

    FileView {
        id: maxFile
        path: root.device ? `/sys/class/backlight/${root.device}/max_brightness` : ""
    }

    FileView {
        id: curFile
        path: root.device ? `/sys/class/backlight/${root.device}/brightness` : ""
        watchChanges: true
        onFileChanged: {
            reload()
            root.changed()
        }
    }

    Process {
        id: setProc
    }
}

