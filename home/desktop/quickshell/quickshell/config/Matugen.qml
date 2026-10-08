pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property Colors colors: Colors {}

    component Colors: QtObject {
        property color text: "#f0dfd7"
        property color subtext: "#52443c"
        property color accent: "#c9ca93"
        property color background: "#19120d"
        property color border: "#c9ca93"
    }
}
