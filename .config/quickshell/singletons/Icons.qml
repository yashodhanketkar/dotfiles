pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string iClose: "\uea76"

    // common
    readonly property string iMonitorSpeaker: "\uf26c"
    readonly property string iLaptop: "\udb80\udf22"
    readonly property string iKeyboard: "\uf11c"
    readonly property string iKeyboardLit: "\udb80\udf0c"

    // wifi
    readonly property string iWiFiConnected: "\udb81\udda9"
    readonly property string iWiFiEnabled: "\udb85\udec7"
    readonly property string iWiFiDisabled: "\udb81\uddaa"

    // bluetooth
    readonly property string iBTConnected: "\udb80\udcb1"
    readonly property string iBTEnabled: "\udb80\udcaf"
    readonly property string iBTDisabled: "\udb80\udcb2"

    // sound
    readonly property string iBTSound: "\udb80\udcb0"
    readonly property string iMute: "\ueb24"
    readonly property string iHeadphones: "\udb80\udecb"

    // brightness
    readonly property string iSun: "\uf522"
    readonly property string iMoon: "\uf186"

    // notification
    readonly property string iBell: "\udb80\udc9a"
    readonly property string iBellDND: "\udb80\udc9b"

    // battery
    readonly property string iBattery: "\udb80\udc79"
    readonly property string iBatteryCritical: "\udb80\udc8e"
    readonly property string iPlugged: "\uf1e6"

    // clock
    readonly property string iTime: "\uf017"
    readonly property string iDateTime: "\udb80\udced"
}
