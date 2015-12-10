//~ BusinessPageInfo
import QtQuick 2.5

QtObject {
    id: businessPageInfo

    property string bussinessName
    property url source
    property url localSource
    property url hotFixSource
    property bool hotFixReady: false
}
