# QtQuickHotFix

QtQuick Hot Fix. 尝试给 QtQuick 应用提供热补订技术。

来个大思路

1. 取安卓上 `Activity` 的思路，对 `QML` 也有相关的类似映射。

2. 对每个重要的业务页面设置本地资源和热补订资源。

    1. localSource

    2. hotFixSource

3. 必须要有一个管理类来管理这些业务页面。

```
//~ BusinessPageInfo
import QtQuick 2.5

QtObject {
    id: businessPageInfo
    
    property string bussinessName
    property url source
    property url localSource
    property url hotFixSource
    property bool checkHotFix: true
    
    function create(parent, properties);
}
```

```js
//~ BusinessPageManager
import QtQuick 2.5

QtObject {
    id: businessPageManager
    property PageStackWindow pageStackWindow: null
    default property bussinessPages alias : businessPageManager.__bussinessPages
    property list<BusinessPageInfo> __bussinessPages
    /*
    function pushBusinessPage(bussinessName, properties) {
        for(var iter in __bussinessPages) {
            if(__bussinessPages[iter].bussinessName == bussinessName) {
                if(pageStackWindow != null) {
                    pageStackWindow.push(__bussinessPages[iter].create(pageStackWindow, properties));
                    break;
                }
            } 
        }
    }*/
}
```

例如在入口 `QML` 文件声明页面角色和路径

```
//~ main.qml
import SomeImportant.Module 1.0

PageStackWindow {
    id: pageStackWindow
    
    initnalPage: MainView {
        
    }
    businessPageManager: BusinessPageManager {
        id: appBusinessPageManager
        
    }
}
```