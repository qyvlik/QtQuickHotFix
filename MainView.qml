import QtQuick 2.0
import Sparrow 1.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Page {
    id: page

    topBar: TopBar {
        RowLayout {
            anchors.fill: parent

            Button {
                text: "try to hot fix"
                onClicked: {
                    tryToHotFixChat();
                }
            }

            Button {
                text: "load chat"
                onClicked: {
                    loadLocalSourceChat();
                }
            }
        }
    }

    function tryToHotFixChat() {
        var bussinessName = "Chat";

        var callback = function (url) {
            __PushPage(url, Component.Asynchronous);
        };

        try {
            pageStackWindow.tryToHotFix("Chat", callback);
        } catch(e) {
            console.log(e)
        }
    }

    function loadLocalSourceChat() {
        try {
            __PushPage(pageStackWindow.getBussinessPageSource("Chat"))
        } catch(e) {
            console.log(e)
        }
    }
}

