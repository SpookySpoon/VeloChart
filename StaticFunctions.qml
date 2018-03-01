pragma Singleton
import QtQuick 2.7

Item {
    id: myStaticObject

    property int legendFontSize: 15

    function getHightColor() {
        return highColor
    }

    function readyChartContex(ctx) {
        ctx.globalCompositeOperation = "source-over";
        ctx.globalAlpha = 0.7;
        ctx.lineCap = "butt"
        ctx.lineJoin = "round"
        ctx.strokeStyle = "#80c342";
        ctx.lineWidth = 3
    }

    function readyErrorContext(ctx) {
        ctx.strokeStyle = "#888888";
        ctx.font = "24px Open Sans"
        ctx.textAlign = "center"
        ctx.shadowOffsetX = 4;
        ctx.shadowOffsetY = 4;
        ctx.shadowBlur = 1.5;
        ctx.shadowColor = "#aaaaaa";
    }

    function updateCanvas(someCanvas) {
        if (someCanvas.available === false) {
            return
        }
        var ctx = someCanvas.getContext("2d");
        ctx.reset();
        someCanvas.requestPaint()
    }
    function readyChartSelContext(ctx) {
        ctx.globalAlpha = 0.7;
        ctx.strokeStyle = "#80c342";
        ctx.lineWidth = 3
    }
    function readyLegendContextX(ctx) {
        ctx.globalAlpha = 0.7;
        ctx.strokeStyle = "#80c342";
        ctx.font = legendFontSize.toString() + "px sans-serif"
        ctx.lineWidth = 1
    }

    function readyLegendContextY(ctx) {
        ctx.globalCompositeOperation = "source-over";
        ctx.lineWidth = 1;
        ctx.globalAlpha = 0.7;
        ctx.strokeStyle = "#80c342";
        ctx.font = legendFontSize.toString() + "px sans-serif"
    }
}
