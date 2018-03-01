import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Layouts 1.1

Rectangle {
    id: root
    width: 320
    height: 480
    color: "transparent"

    property var stock: null
    property var stocklist: null

    Rectangle {
        id: mainRect
        color: "transparent"
        anchors.fill: parent

        GridLayout {
            anchors.fill: parent
            rows: 1
            columns: 1

            StockChart {
                id: chart
                Layout.margins: 10
                Layout.row: 0
                Layout.column: 0
                Layout.fillWidth: true
                Layout.fillHeight: true
                stockModel: root.stock
            }
        }
    }
}
