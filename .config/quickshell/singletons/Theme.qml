pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property color colBg:      "#000105"
    readonly property color colFg:      "#EAD8DB"
    readonly property color colCursor:  "#A38A94"

    readonly property color col1:  "#000105"
    readonly property color col2:  "#212C36"
    readonly property color col3:  "#452E39"
    readonly property color col4:  "#6B2738"
    readonly property color col5:  "#703E4A"
    readonly property color col6:  "#AE354B"
    readonly property color col7:  "#926B72"
    readonly property color col8:  "#D8BFC3"
    readonly property color col9:  "#978588"
    readonly property color col10: "#2C3B48"
    readonly property color col11: "#5B3D4C"
    readonly property color col12: "#8F344A"
    readonly property color col13: "#955363"
    readonly property color col14: "#E84764"
    readonly property color col15: "#C28F98"
    readonly property color col16: "#D8BFC3"

    readonly property color colFine: "#008002"
    readonly property color colWarn: "#800002"

    readonly property string fontFamily: "JetBrains Mono"
    readonly property int fontSize:      14
    readonly property int fontSmall:     12
    readonly property int radius:        8
    readonly property int height:        30
}
