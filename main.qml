import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtMultimedia 5.9

ApplicationWindow {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    color: "#000000"
    Component.onCompleted: {
        //mainWindow.showFullScreen()
    }
    onVisibilityChanged: {
        if (visibility == Qt.WindowMaximized) {
            mainWindow.showFullScreen()
        }
    }

    Label {
        id: clockLabel
        y: 60
        text: "00:00:00"
        color: "white"
        font.pixelSize: 100
        anchors.horizontalCenter: parent.horizontalCenter
    }

    RoundButton {
        width: 30
        height: 30
        text: "ー"
        font.pixelSize: 20
        anchors.right: parent.right
        anchors.rightMargin: 5
        y: 5

        onClicked: {
            mainWindow.showMinimized()
        }
    }

    Timer {
        interval: 1000; running: true; repeat: true;
        onTriggered: {
            clockLabel.text = new Date().toLocaleTimeString()
            if (new Date().getSeconds() % 2 == 0) {
                second2.play()
            } else {
                second1.play()
            }
        }
    }

    SoundEffect {
        id: second1
        source: "second1.wav"
        volume: 0.05
    }
    SoundEffect {
        id: second2
        source: "second2.wav"
        volume: 0.05
    }
}
