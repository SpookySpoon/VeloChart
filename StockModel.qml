import QtQuick 2.0
import MyCustomModel 1.0

CustomModel {
    id: model

    property int setStart: 0
    property int setSize: 0

    property int localMax: 0
    property int localMin: 0
    property int localValueRange: Math.max(1, localMax - localMin)

    function calculateExtremums(min, max) {
        var lMin = Math.min(Math.max(min, 0), model.count - 1)
        var lMax = Math.min(Math.max(max, 0), model.count - 1)
        localMax = model.getValueY(lMin)

        localMin = localMax
        for (var i = lMin + 1; i <= lMax; i++) {
            var newVal = model.getValueY(i)


            if (newVal > localMax) {
                localMax = newVal
            } else if (newVal < localMin) {
                localMin = newVal
            }
        }
    }

    function setLast() {
        return setStart + setSize - 1
    }

    function changeSetStart(change) {
        model.setStart = Math.max(Math.min(model.setStart + change, model.count - model.setSize), 0)
    }

    function changeSetSize(change) {
        model.setSize = Math.min(Math.max(model.setSize + change, 2), model.count)
        model.changeSetStart(Math.min(model.count - (model.setStart + model.setSize), 0))
    }
}
