pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

Singleton {
    id: root

    readonly property bool plugged: UPower.displayDevice.powerSupply
    readonly property var perCharge: UPower.displayDevice.percentage
    readonly property var status: UPowerDeviceState.toString(UPower.displayDevice.state)

    property string charge: parseInt(parseFloat(perCharge) * 100)

    function getStatusColor() {
        const lvl = parseInt(charge) || 0;

        if (lvl < 20)
            return Theme.colWarn;
        if (plugged && lvl < 90)
            return Theme.colFine;
        return Theme.col2;
    }
}
