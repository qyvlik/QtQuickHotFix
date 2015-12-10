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
                text: "go back"
                onClicked: {
                    stackView.pop()
                }
            }
        }
    }
    Text {
        anchors.centerIn: parent
        text: "Im the hot fix...."
    }
}

