import Quickshell
import Quickshell.Io

Scope {
    PanelWindow {
        id: launcher

        visible: false
        implicitWidth: 512
        implicitHeight: 256

    }

    IpcHandler {
        target: "launcher"

        function toggleVisible(): void {
            launcher.visible = !launcher.visible ? true : false
        }
    }
}
