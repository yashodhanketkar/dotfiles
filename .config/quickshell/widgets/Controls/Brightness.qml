import QtQuick
import "../../singletons/"
import "../../components/"
import "../../components/Brightness/"

Rectangle {
    id: root

    color: Theme.col2
    implicitWidth: bCore.desiredWidth
    implicitHeight: Theme.height
    radius: Theme.radius
    clip: true

    BrightnessCore {
        id: bCore
    }

    Tooltip {
        target: root
        text: "Right click to turn " + (BrightnessService.nightMode ? "off" : "on") + " night mode"
        show: bCore.iconHovered
    }
}
