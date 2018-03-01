import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")



    StockView {
        id: stockView
        anchors.fill: parent
        stock: stock
    }
    StockModel {
        id: stock
        setSize: stock.count
        setStart: 0
    }
}
