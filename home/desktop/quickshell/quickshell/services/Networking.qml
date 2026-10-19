pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    // devices (empty string = none detected)
    property string wifiDevice: ""
    property string ethernetDevice: ""

    property bool wifiEnabled: false
    property var activeWifi: null   // { ssid, rssi } or null

    readonly property bool ethernetConnected: ethernetDevice !== ""
    readonly property bool connected: ethernetConnected || activeWifi !== null
    readonly property string connectionType: ethernetConnected ? "ethernet" : (activeWifi ? "wifi" : "none")

    function getIcon(): string {
        if (ethernetConnected) return "ethernet"
        if (activeWifi) {
            const rssi = activeWifi.rssi
            if (rssi > -70) return "wifi-excellent"
            if (rssi > -80) return "wifi-moderate"
            if (rssi > -90) return "wifi-weak"
            return "wifi-zero"
        }
        if (!wifiEnabled) return "wifi-disabled"
        return "offline"
    }

    function setWifiEnabled(enabled: bool) {
        if (wifiDevice === "") return
        toggle.command = ["iwctl", "device", wifiDevice, "set-property", "Powered", enabled ? "on" : "off"]
        toggle.running = true
    }

    function parse(text: string) {
        const kv = {}
        let eth = ""
        let wifi = ""

        for (const raw of text.split("\n")) {
            // strip ANSI color codes
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
        if (wifi !== "" && kv["State"] === "connected" && ssid)
            activeWifi = { ssid: ssid, rssi: parseInt(kv["RSSI"] ?? "-100") }
        else
            activeWifi = null
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
