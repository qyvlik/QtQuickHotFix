import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    id: pageStackWindow
    title: qsTr("WellChat")
    width: 360
    height: 640
    visible: true
    color: "#ebebeb"

    style: ApplicationWindowStyle {
        background: Rectangle {
            width: pageStackWindow.width
            height: pageStackWindow.height
            color: pageStackWindow.color
        }
    }

    property alias initialPage: __stackView.initialItem
    property alias focus: __stackView.focus
    property alias stackView: __stackView
    readonly property alias currentItem: __stackView.currentItem
    readonly property alias depth: __stackView.depth
    readonly property alias busy: __stackView.busy

    property BusinessPageManager businessPageManager: null

    StackView {
        id: __stackView
        anchors.fill: parent
        focus: visible
    }

    onInitialPageChanged: {
        // @disable-check M126
        if(initialPage.stackView == null) {
            initialPage.stackView = pageStackWindow.stackView
        }
    }

    function clear() { __stackView.clear(); }
    function push(item) { return  __stackView.push(item); }
    function pop(item) { return  __stackView.pop(item); }

    function fixLocalSource(bussinessName, hotFixSource) {
        if(businessPageManager != null) {
            for(var iter in businessPageManager.bussinessPages) {
                if(businessPageManager
                        .bussinessPages[iter]
                        .bussinessName
                        === bussinessName)
                {
                    businessPageManager
                    .bussinessPages[iter]
                    .hotFixSource = hotFixSource;

                    businessPageManager
                    .bussinessPages[iter]
                    .hotFixReady = true;

                    return true;
                }
            }
            return false;
        } else {
            throw "bussinessName:" + bussinessName + "not exites";
        }
    }

    function getBussinessPageSource(bussinessName) {
        if(businessPageManager != null) {
            for(var iter in businessPageManager.bussinessPages) {
                if(businessPageManager
                        .bussinessPages[iter]
                        .bussinessName
                        === bussinessName)
                {
                    return businessPageManager
                    .bussinessPages[iter]
                    .localSource;
                }
            }
        } else {
            throw "bussinessName:" + bussinessName + "not exites";
        }
    }

    //
    /*
{
    "hotfix": "false",
    "businessName":"Chat",
    "source": "http://qyvlik.sinaapp.com/Chat.qml"
}
        */
    // callback(bussinessPageHotFixUrl)
    function tryToHotFix(businessName, callback) {
        if(businessPageManager != null) {
            var hotFixUrl = businessPageManager.hotFixUrl;
            var appHotFixObject = {
                "hotfix": "false",
                "businessName":"Chat",
                "source": "http://qyvlik.sinaapp.com/Chat.qml"
            };

            var xhr  = new XMLHttpRequest;
            xhr.onreadystatechange = function() {
                if(xhr.readyState == xhr.DONE) {
                    try {
                        var temp = JSON.parse(xhr.responseText);
                        appHotFixObject.hotfix =temp.hotfix;
                        appHotFixObject.businessName = temp.businessName;
                        appHotFixObject.source = temp.source;

                        if(appHotFixObject.businessName === businessName) {
                            fixLocalSource(businessName, appHotFixObject.source);
                            console.log("callback...")
                            callback(appHotFixObject.source);
                        }

                    } catch(e) {
                        console.log(e);
                    }
                }
            }
            xhr.open("GET",hotFixUrl);
            xhr.send()
        }else {
            throw "bussinessName:" + bussinessName + "not exites";
        }
    }
}

