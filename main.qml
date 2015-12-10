import QtQuick 2.5
import QtQuick.Window 2.2
import Sparrow 1.0

PageStackWindow {
    id: mainWindow

    initialPage: MainView {
        pageStackWindow: mainWindow
    }

    businessPageManager:
        BusinessPageManager {
        hotFixUrl: "http://qyvlik.sinaapp.com/hotfix.json"
        BusinessPageInfo {
            bussinessName: "Chat"
            localSource: Qt.resolvedUrl("./Chat.qml");
        }
    }
}

