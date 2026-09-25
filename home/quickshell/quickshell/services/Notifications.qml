pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property alias notifications: server.trackedNotifications

    NotificationServer {
        id: server

        actionsSupported: false
        bodySupported: true
        bodyMarkupSupported: false
        imageSupported: true

        onNotification: notification => {
            notification.tracked = true
        }
    }
}
