import "../../singletons/"
import "../../utils/"
import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
    id: root

    Layout.alignment: Qt.AlignVCenter
    implicitWidth: pillRow.implicitWidth + 20
    implicitHeight: 30
    radius: 8
    color: Theme.col2

    Text {
        id: pillRow

        anchors.centerIn: parent
        text: [SystemStats.cpuUsage, SystemStats.ramUsage, SystemStats.homeUsage].map((v) => {
            return String(v).padStart(2, "0") + "%";
        }).join(" | ")
        color: Theme.col8

        font {
            family: Theme.fontFamily
            pixelSize: Theme.fontSize
            bold: true
        }

    }

    MouseArea {
        id: hoverArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }

    PopupWindow {
        id: statsPopup

        visible: hoverArea.containsMouse
        implicitWidth: 280
        implicitHeight: mainCard.implicitHeight
        color: "transparent"

        anchor {
            item: root
            edges: Edges.Bottom
            gravity: Edges.Bottom
            rect.y: root.height + 8
        }

        Rectangle {
            id: mainCard

            width: parent.width
            implicitHeight: cardColumn.implicitHeight + 20
            radius: 10
            color: Theme.col2

            ColumnLayout {
                id: cardColumn

                anchors.fill: parent
                anchors.margins: 10
                spacing: 8

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: freqCol.implicitHeight + 16
                    radius: 8
                    color: "transparent"
                    border.color: Theme.col7
                    border.width: 1

                    ColumnLayout {
                        id: freqCol

                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 6

                        Text {
                            text: "AVG FREQ: " + SystemStats.avgFreqMhz.toFixed(1) + " MHz"
                            color: Theme.colFg

                            font {
                                family: Theme.fontFamily
                                pixelSize: Theme.fontSize - 1
                                bold: true
                            }

                        }

                        ProgressBar {
                            Layout.fillWidth: true
                            value: (SystemStats.avgFreqMhz / SystemStats.maxFreqMhz) * 100
                            fillColor: Theme.col7
                        }

                    }

                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: coresCol.implicitHeight + 16
                    radius: 8
                    color: "transparent"
                    border.color: Theme.col7
                    border.width: 1

                    ColumnLayout {
                        id: coresCol

                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 4

                        Repeater {
                            model: SystemStats.perCoreStats

                            RowLayout {
                                required property var modelData

                                Layout.fillWidth: true

                                Text {
                                    text: parent.modelData.name + ": " + parent.modelData.usage + "%"
                                    color: Theme.colFg

                                    font {
                                        family: Theme.fontFamily
                                        pixelSize: Theme.fontSize - 1
                                        bold: true
                                    }

                                }

                                Item {
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: modelData.freq + " MHz"
                                    color: Theme.col7

                                    font {
                                        family: Theme.fontFamily
                                        pixelSize: Theme.fontSize - 1
                                    }

                                }

                            }

                        }

                    }

                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: ramCol.implicitHeight + 16
                    radius: 8
                    color: "transparent"
                    border.color: Theme.col7
                    border.width: 1

                    ColumnLayout {
                        id: ramCol

                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 6

                        Text {
                            text: "RAM: " + SystemStats.ramPercent.toFixed(2) + "% (" + SystemStats.ramUsedMiB + "MiB / " + SystemStats.ramTotalMiB + "MiB)"
                            color: Theme.colFg

                            font {
                                family: Theme.fontFamily
                                pixelSize: Theme.fontSize - 1
                                bold: true
                            }

                        }

                        ProgressBar {
                            Layout.fillWidth: true
                            value: SystemStats.ramPercent
                            fillColor: Theme.col7
                        }

                    }

                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: diskCol.implicitHeight + 16
                    radius: 8
                    color: "transparent"
                    border.color: Theme.col7
                    border.width: 1

                    ColumnLayout {
                        id: diskCol

                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 8

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 6

                            Text {
                                text: "HOME: " + SystemStats.homePercent.toFixed(2) + "% (" + SystemStats.homeUsed + "/" + SystemStats.homeTotal + ")"
                                color: Theme.colFg

                                font {
                                    family: Theme.fontFamily
                                    pixelSize: Theme.fontSize - 1
                                    bold: true
                                }

                            }

                            ProgressBar {
                                Layout.fillWidth: true
                                value: SystemStats.homePercent
                                fillColor: Theme.col7
                            }

                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 6

                            Text {
                                text: "BOOT: " + SystemStats.bootPercent.toFixed(2) + "% (" + SystemStats.bootUsed + "/" + SystemStats.bootTotal + ")"
                                color: Theme.colFg

                                font {
                                    family: Theme.fontFamily
                                    pixelSize: Theme.fontSize - 1
                                    bold: true
                                }

                            }

                            ProgressBar {
                                Layout.fillWidth: true
                                value: SystemStats.bootPercent
                                fillColor: Theme.col7
                            }

                        }

                    }

                }

            }

        }

    }

}
