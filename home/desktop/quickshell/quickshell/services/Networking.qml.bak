pragma Singleton

import Quickshell
import Quickshell.Networking as Net
import QtQuick

Singleton {
    id: root

    readonly property var wifiDevice: Net.Networking.devices.values.find(d => d.type === Net.DeviceType.Wifi) ?? null
    readonly property var wiredDevice: Net.Networking.devices.values.find(d => d.type === Net.DeviceType.Wired) ?? null

    // wifi
    readonly property bool wifiEnabled: Net.Networking.wifiEnabled
    readonly property var networks: wifiDevice?.networks?.values ?? []
    readonly property var activeWifi: networks.find(n => n.connected) ?? null

    // ethernet
    readonly property bool ethernetConnected: wiredDevice?.connected ?? false
    readonly property string ethernetDevice: wiredDevice?.name ?? ""

    readonly property bool connected: ethernetConnected || activeWifi !== null
    readonly property string connectionType: ethernetConnected ? "ethernet" : (activeWifi ? "wifi" : "none")

    function getIcon(): string {
        if (ethernetConnected) return "ethernet"
        if (activeWifi) return wifiIcon(activeWifi)
        if(!wifiEnabled) return "wifi-disabled"
        return "offline"
    }

    function wifiIcon(wifiNetwork): string {
        const s = wifiNetwork?.signalStrength ?? 0;

        // should be similar to macOS
        if(s >= 0.5) return "wifi-excellent"
        if(s >= 0.33) return "wifi-moderate"
        if(s > 0) return "wifi-weak"
        return "wifi-zero"
    }
}
