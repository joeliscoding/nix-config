pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property Colors colors: Colors {}

    component Colors: QtObject {
        property color text: "{{ colors.on_surface.default.hex }}"
        property color subtext: "{{ colors.surface_variant.default.hex }}"
        property color accent: "{{ colors.tertiary.default.hex }}"
        property color background: "{{ colors.surface.default.hex }}"
        property color border: "{{ colors.tertiary.default.hex }}"
    }
}
