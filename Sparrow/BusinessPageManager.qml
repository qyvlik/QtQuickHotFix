//~ BusinessPageManager
import QtQuick 2.5

QtObject {
    id: businessPageManager
    default property  alias bussinessPages : businessPageManager.__bussinessPages
    property list<BusinessPageInfo> __bussinessPages
    property url hotFixUrl
}
