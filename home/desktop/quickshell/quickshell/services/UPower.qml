pragma Singleton

import Quickshell
import Quickshell.Services.UPower as QsUPower
import QtQuick

Singleton {
    id: root

    readonly property QsUPower.UPowerDevice displayDevice: QsUPower.UPower.displayDevice

    readonly property bool isPresent: displayDevice?.isPresent ?? false
    readonly property real percentage: displayDevice?.percentage ?? 0
    readonly property int state: displayDevice?.state ?? QsUPower.UPowerDeviceState.Unknown
    readonly property bool charging: state === QsUPower.UPowerDeviceState.Charging
    readonly property bool discharging: state === QsUPower.UPowerDeviceState.Discharging
    readonly property bool fullyCharged: state === QsUPower.UPowerDeviceState.FullyCharged

    function getPercentage(): string {
        return Math.round(percentage * 100) + (charging ? "󱐋" : "");
    }

    function getIcon(): string {
        if (percentage >= 0.99) return "battery-full";
        if (percentage >= 0.9) return "battery-90";
        if (percentage >= 0.8) return "battery-80";
        if (percentage >= 0.6) return "battery-60";
        if (percentage >= 0.5) return "battery-50";
        if (percentage >= 0.3) return "battery-30";
        return "battery-20";

        //if (charging || fullyCharged) icon += "-charging";
    }
}
