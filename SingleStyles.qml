pragma Singleton

import QtQuick 2.0
QtObject {

    property FontLoader fontLatoBlackLoader: FontLoader {
        name: "fontLatoBlack"
        source: "qrc:/fonts/Lato-Black.ttf"
    }
}
