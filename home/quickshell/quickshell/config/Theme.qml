pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property Colors colors: Colors {}

    component Colors: QtObject {
        property color text: "#ffffff"
        property color subtext: "#4c4c4c"
        property color accent: "#ff0000"
        property color background: "#1a1a1a"
        property color border: "#ffffff"
    }
}
