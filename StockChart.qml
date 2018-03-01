import QtQuick 2.7
import QtQuick.Layouts 1.1
import Utils 1.0
import "."

Rectangle {
    id: chart
    property var stockModel: null
    property real pixelPerUnit: getPixelPerUnit()
    property real paintOffset: 0
    onWidthChanged: {
        updatePixelPerUnit()
        chartRect.updateSelection(false)
    }
    onStockModelChanged: {
        stockModel.calculateExtremums(chart.getRenderStartIndex(), chart.getRenderEndIndex())
    }

    function updatePixelPerUnit() {
        chart.pixelPerUnit = getPixelPerUnit()
    }

    function getPixelPerUnit() {
        return (stockModel == null ? 1 : chartRect.width / Math.max(stockModel.setSize - 1, 1))
    }

    function update() {
        Utils.updateCanvas(canvasChart)
        Utils.updateCanvas(verticalAxisCanvas)
        Utils.updateCanvas(horizontalAxisCanvas)
    }

    function getHoveredModelItemIndex() {
        var realPosX = chartMouseArea.mousePosX - chart.paintOffset
        var incompliteItemPosX = realPosX % chart.pixelPerUnit
        var hoveredItem = (realPosX - incompliteItemPosX) / chart.pixelPerUnit + stockModel.setStart
        if (incompliteItemPosX >= chart.pixelPerUnit / 2) {
            hoveredItem += 1
        }
        return hoveredItem
    }

    function trimPaintOffset() {
        var wholeOffsets = (chart.paintOffset / chart.pixelPerUnit) | 0
        var remainedOffset = chart.paintOffset - wholeOffsets * chart.pixelPerUnit
        stockModel.changeSetStart(-wholeOffsets)
        if (stockModel.setStart === 0) {
            remainedOffset = Math.min(0, remainedOffset)
        }
        if (stockModel.setLast() === stockModel.count - 1) {
            remainedOffset = Math.max(0, remainedOffset)
        }
        chart.paintOffset = remainedOffset
    }

    function getRenderStartIndex() {
        return chart.paintOffset > 0 ? Math.max(stockModel.setStart - 1, 0) : stockModel.setStart;
    }

    function getRenderEndIndex() {
        return chart.paintOffset < 0 ? Math.min(stockModel.setLast() + 1, stockModel.count - 1) : stockModel.setLast()
    }

    GridLayout {
        anchors.fill: parent
        columnSpacing : 0
        rowSpacing : 0
        Rectangle {
            id: chartRect
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.row: 0
            Layout.column: 0

            property int marginTop: Utils.legendFontSize * 2
            function getItemPosX(index) {
                return Math.floor(chart.paintOffset + index * chart.pixelPerUnit);
            }

            function getItemPosY(val) {
                var h = chartRect.height - chartRect.marginTop;
                return chartRect.marginTop + h * (stockModel.localMin - val) / stockModel.localValueRange + h;
            }

            MouseArea {
                id: chartMouseArea
                property int mousePosX: 0
                property int mousePosY: 0
                anchors.fill: parent
                hoverEnabled: true
                onReleased: {
                    chartRect.updateSelection()
                }
                onPositionChanged: {
                    if (chartMouseArea.pressed) {
                        chart.paintOffset += (mouse.x - chartMouseArea.mousePosX)
                        trimPaintOffset()
                        stockModel.calculateExtremums(chart.getRenderStartIndex(), chart.getRenderEndIndex())
                    }
                    chartRect.updateSelection(!chartMouseArea.pressed)
                    chart.update()
                    mousePosX = mouse.x
                    mousePosY = mouse.y
                }
                onWheel: {
                    var oldSetValPos = wheel.x
                    var delta = wheel.angleDelta.y / 120
                    var setVal = (oldSetValPos - chart.paintOffset) / chart.pixelPerUnit

                    stockModel.changeSetSize(delta)
                    chart.updatePixelPerUnit()

                    var newSetValPos = chart.paintOffset + setVal * chart.pixelPerUnit
                    var deltaSetVal = newSetValPos - oldSetValPos
                    if (stockModel.setLast() === stockModel.count - 1 && delta > 0) {
                        var rightChartEndDiff = chart.paintOffset + (stockModel.setSize - 1) * chart.pixelPerUnit - chartRect.width
                        chart.paintOffset -= Math.min(rightChartEndDiff, -deltaSetVal)
                    } else if (!(stockModel.setStart === 0 && deltaSetVal < 0)) {
                        chart.paintOffset -= deltaSetVal
                    }

                    trimPaintOffset()
                    stockModel.calculateExtremums(chart.getRenderStartIndex(), chart.getRenderEndIndex())
                    chartRect.updateSelection(true)
                    chart.update()
                }
            }

            Canvas {
                id: canvasChart
                anchors.fill: parent
                function drawError(msg)
                {
                    var ctx = canvasChart.getContext("2d");
                    ctx.save();
                    Utils.readyErrorContext(ctx)
                    ctx.beginPath();
                    ctx.fillText(msg, canvasChart.width / 2, canvasChart.height / 2);
                    ctx.closePath();
                    ctx.stroke();
                    ctx.restore();
                }

                onPaint: {
                    if (!stockModel.count === 0) {
                        canvasChart.drawError("No data available.");
                        return;
                    }
                    var ctx = canvasChart.getContext("2d");
                    ctx.save();
                    Utils.readyChartContex(ctx)
                    ctx.beginPath();
                    var start = true
                    for (var i = chart.getRenderStartIndex(), end = chart.getRenderEndIndex(); i <= end; i++) {
                        var price = stockModel.getValueY(i);
                        var x = chartRect.getItemPosX(i - stockModel.setStart);
                        var y = chartRect.getItemPosY(price);
                        if (start) {
                            ctx.moveTo(x, y)
                            start = false
                        } else {
                            ctx.lineTo(x, y)
                        }
                    }
                    ctx.stroke();
                    ctx.restore();
                }
            }

            function updateSelection(updateIndex) {
                if (updateIndex === true) {
                    canvasSelection.currentIndex = getHoveredModelItemIndex()
                }
                canvasSelection.currentY = chartRect.getItemPosY(stockModel.getValueY(canvasSelection.currentIndex));
                canvasSelection.currentX = chartRect.getItemPosX(canvasSelection.currentIndex - stockModel.setStart);
                Utils.updateCanvas(canvasSelection)
            }

            Canvas {
                id: canvasSelection
                anchors.fill: parent
                property int currentX: -1
                property int currentY: -1
                property int currentIndex: -1
                onCurrentIndexChanged: {
                    var ctx = canvasSelection.getContext("2d");
                    ctx.save();
                    Utils.readyLegendContextX(ctx)
                    ctx.beginPath();
                    var txt = stockModel.getValueYComment(currentIndex, horizontalAxisCanvas.axisLegendFormatX)
                    ctx.fillText(txt, 0, Utils.legendFontSize)
                    ctx.moveTo(0, 0)
                    ctx.lineTo(canvasSelection.width, canvasSelection.height)
                    ctx.stroke();
                    ctx.restore();
                    ctx.closePath()
                }

                onPaint: {
                    if (currentIndex == -1 ||
                            currentIndex < stockModel.setStart ||
                            currentIndex >= stockModel.setStart + stockModel.setSize) {
                        return
                    }
                    var ctx = canvasSelection.getContext("2d");
                    ctx.save();
                    Utils.readyChartSelContext(ctx)
                    ctx.beginPath();
                    ctx.ellipse(currentX - 4, currentY - 4, 9, 9)
                    ctx.fill()
                    ctx.stroke();
                    ctx.restore();
                    ctx.closePath()

                    Utils.readyLegendContextX(ctx)
                    ctx.beginPath();
                    var txt = stockModel.getValueYComment(currentIndex, horizontalAxisCanvas.axisLegendFormatX)
                    ctx.fillText(txt, 0, Utils.legendFontSize)
                    ctx.stroke();
                    ctx.restore();
                    ctx.closePath()
                }
            }
        }

        Rectangle {
            id: horizontalAxis
            Layout.row: 1
            Layout.column: 0
            implicitHeight: 1
            Layout.fillWidth: true
            Canvas {
                id: horizontalAxisCanvas
                anchors.fill: parent
                property string axisLegendFormatX: "dd.MM.yyyy"
                onPaint: {
                    var ctx = horizontalAxisCanvas.getContext("2d")
                    ctx.save();
                    Utils.readyLegendContextX(ctx)
                    horizontalAxis.implicitHeight = Utils.legendFontSize * 1.1
                    var xMargin = 5
                    var legendFormatText = horizontalAxisCanvas.axisLegendFormatX
                    var axisXItemWidth = ctx.measureText(legendFormatText).width * 1.5 + xMargin
                    var lMarkPerItem = Math.max(axisXItemWidth / chart.pixelPerUnit, 1)
                    var modeltemRenderMaxIndex = Math.floor((stockModel.count - 1) / lMarkPerItem)
                    lMarkPerItem = (stockModel.count - 1) / modeltemRenderMaxIndex

                    var startIndex = chart.getRenderStartIndex()
                    var endIndex = chart.getRenderEndIndex()

                    var indexToRenderBegin = -1
                    for (var i = startIndex; i < endIndex; i++) {
                        var x = chartRect.getItemPosX(i - stockModel.setStart);
                        if (x < 0) {
                            continue
                        }
                        var lItemIndex = Math.min(Math.floor(i / lMarkPerItem), modeltemRenderMaxIndex)
                        if (Math.ceil(lItemIndex * lMarkPerItem) === i) {
                            indexToRenderBegin = lItemIndex
                            break
                        }
                    }

                    var indexToRenderEnd = -2
                    for (var e = endIndex; e > startIndex; e--) {
                        var xEnd = chartRect.getItemPosX(e - stockModel.setStart);
                        if (xEnd > horizontalAxisCanvas.width) {
                            continue
                        }
                        if (e === stockModel.count - 1) {
                            indexToRenderEnd = modeltemRenderMaxIndex
                            break
                        }
                        var lItemIndex1 = Math.floor(e / lMarkPerItem)

                        if (Math.ceil(lItemIndex1 * lMarkPerItem) === e) {
                            indexToRenderEnd = Math.min(lItemIndex1,  modeltemRenderMaxIndex)
                            break
                        }
                    }

                    ctx.beginPath()
                    ctx.moveTo(horizontalAxisCanvas.width, 0)
                    ctx.lineTo(0, 0)
                    for (var rI = indexToRenderBegin; rI <= indexToRenderEnd; rI ++) {
                        var finalIndex = Math.min(Math.floor(rI * lMarkPerItem), stockModel.count -1)
                        var txt = stockModel.getValueX(finalIndex, legendFormatText)
                        var txtWidth = ctx.measureText(txt).width
                        var posX = chartRect.getItemPosX(finalIndex - stockModel.setStart)
                        ctx.fillText(txt, Math.min(Math.max(0, posX - txtWidth / 2), horizontalAxisCanvas.width - txtWidth), Utils.legendFontSize);
                        ctx.moveTo(posX, 5)
                        ctx.lineTo(posX, 0)
                    }
                    ctx.stroke()
                    ctx.restore()
                    ctx.closePath()
                }
            }
        }

        Rectangle {
            id: verticalAxis
            Layout.fillHeight: true
            Layout.row: 0
            Layout.column: 1
            implicitWidth: 1
             Canvas {
                id: verticalAxisCanvas
                anchors.fill: parent
                property int minWidth: 0

                onPaint: {
                    var ctx = verticalAxisCanvas.getContext("2d");
                    ctx.save();
                    Utils.readyLegendContextY(ctx)
                    verticalAxis.implicitWidth = ctx.measureText(parseFloat(stockModel.localMax).toFixed(0)).width + 7
                    ctx.beginPath();
                    var priceStep = (stockModel.localMax - stockModel.localMin) / 5;
                    for (var i = 0; i < 5; i ++) {
                        var price = parseFloat(stockModel.localMax - i * priceStep).toFixed(0);
                        var posY = chartRect.getItemPosY(price)
                        ctx.moveTo(0, posY)
                        ctx.lineTo(5, posY)
                        ctx.fillText(price, 7, posY + 5);
                    }
                    ctx.moveTo(0, 0)
                    ctx.lineTo(0, verticalAxisCanvas.height)
                    ctx.closePath();
                    ctx.stroke();
                    ctx.restore();
                }
            }
        }
    }
}
