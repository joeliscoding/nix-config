pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    // wifi-devices (empty string for auto detection)
    property string wifiDevice: ""
    property string ethernetDevice: ""

    // wifi
    property bool wifiEnabled: false
    property var activeWifi: null   // { ssid, rssi, signalStrength } or null

    // ethernet
    property bool ethernetConnected: ethernetDevice !== ""

    readonly property bool connected: ethernetConnected || activeWifi !== null
    readonly property string connectionType: ethernetConnected ? "ethernet" : (activeWifi ? "wifi" : "none")

    function getIcon(): string {
        if (ethernetConnected) return "ethernet"
        if (activeWifi) return wifiIcon(activeWifi)
        if (!wifiEnabled) return "wifi-disabled"
        return "offline"
    }

    function wifiIcon(wifiNetwork): string {
        const s = wifiNetwork?.signalStrength ?? 0

        // should be similar to macOS
        if (s >= 0.66) return "wifi-excellent"
        if (s >= 0.33) return "wifi-moderate"
        if (s > 0) return "wifi-weak"
        return "wifi-zero"
    }

    function setWifiEnabled(enabled: bool) {
        if (wifiDevice === "") return
        toggle.command = ["iwctl", "device", wifiDevice, "set-property", "Powered", enabled ? "on" : "off"]
        toggle.running = true
    }

    // RSSI (dBm) -> 0..1  (-60 dBm ≈ 0.5, -70 dBm ≈ 0.33, -90 dBm = 0)
    function rssiToStrength(rssi: int): real {
        return Math.max(0, Math.min(1, (rssi + 90) / 60))
    }

    function parse(text: string) {
        const kv = {}
        let eth = ""
        let wifi = ""

        for (const raw of text.split("\n")) {
            // remove ANSI color codes
            const line = raw.replace(/\x1b\[[0-9;]*m/g, "").trim()

            if (line.startsWith("@eth="))  { eth = line.slice(5);  continue }
            if (line.startsWith("@wifi=")) { wifi = line.slice(6); continue }

            const m = line.match(/^(.+?)\s{2,}(.+)$/)
            if (m) kv[m[1]] = m[2]
        }

        ethernetDevice = eth
        wifiDevice = wifi
        wifiEnabled = kv["Powered"] === "on"

        const ssid = kv["Connected network"]
        if (wifi !== "" && kv["State"] === "connected" && ssid) {
            const rssi = parseInt(kv["RSSI"] ?? "-100")
            activeWifi = { ssid: ssid, rssi: rssi, signalStrength: rssiToStrength(rssi) }
        } else {
            activeWifi = null
        }
    }

    Process {
        id: poll
        command: ["sh", "-c", `
            eth=""; wl=""
            for d in /sys/class/net/*; do
                n=\${d##*/}
                [ "$n" = lo ] && continue
                if [ -d "$d/wireless" ]; then
                    [ -z "$wl" ] && wl=$n
                else
                    case $n in
                        en*|eth*) [ "$(cat "$d/carrier" 2>/dev/null)" = 1 ] && eth=$n ;;
                    esac
                fi
            done
            echo "@eth=$eth"
            echo "@wifi=$wl"
            if [ -n "$wl" ]; then
                iwctl station "$wl" show 2>/dev/null
                iwctl device "$wl" show 2>/dev/null
            fi
        `]
        stdout: StdioCollector {
            onStreamFinished: root.parse(text)
        }
    }

    Process {
        id: toggle
        onRunningChanged: if (!running) poll.running = true
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: if (!poll.running) poll.running = true
    }
}

