pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire as QsPipewire
import QtQuick

Singleton {
    id: root

    QsPipewire.PwObjectTracker {
        objects: [QsPipewire.Pipewire.defaultAudioSink, QsPipewire.Pipewire.defaultAudioSource]
    }

    readonly property QsPipewire.PwNode sink: QsPipewire.Pipewire.defaultAudioSink
    readonly property real sinkVolume: sink?.audio?.volume ?? 0
    readonly property bool sinkMuted: sink?.audio?.muted ?? false

    property bool ready: false

    signal changed()

    Connections {
        target: root.sink?.audio ?? null
        function onVolumeChanged() { if (root.ready) root.changed() }
        function onMutedChanged() { if (root.ready) root.changed() }
    }

    Component.onCompleted: readyTimer.start()
    Timer {
        id: readyTimer
        interval: 500
        onTriggered: root.ready = true
    }

    readonly property string sinkIcon: {
        if (sinkMuted) return "volume-mute";
        if (sinkVolume > 0.66) return "volume-high";
        if (sinkVolume > 0.33) return "volume-medium";
        if (sinkVolume > 0.01) return "volume-low";
        return "volume-mute";
    }

    readonly property string sinkVolumeString: {
        return Math.round(sinkVolume * 100) + "%"
    }
}
