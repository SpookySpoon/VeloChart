pragma Singleton
import QtQuick 2.2

Item {
//    property LegendRendererY active: LegendRendererY { colorGroup: LegendRendererY.Active }
//    property LegendRendererY disabled: LegendRendererY { colorGroup: LegendRendererY.Disabled }

    function readyContext(ctx) {
        ctx.globalCompositeOperation = "source-over";
        ctx.lineWidth = 1;
        ctx.save();
        ctx.globalAlpha = 0.7;
        ctx.strokeStyle = "#80c342";
    }
}
