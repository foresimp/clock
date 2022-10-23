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

    onVisibilityChanged: {
        if (visibility == Qt.WindowMaximized) {
            mainWindow.showFullScreen()
        }
    }

    Label {
        id: clockLabel
        y: 400
        text: "00時00分00秒"
        color: "white"
        font.pointSize: 200
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
        onPressAndHold: {
            close()
        }
    }

    RoundButton {
        width: 30
        height: 30
        text: "S"
        font.pixelSize: 20
        x: 5
        y: 5

        onClicked: {
            second1.muted = !second1.muted
            second2.muted = !second2.muted
            if (second1.muted) {
                text = "M"
            } else {
                text = "S"
            }
        }
    }

    Timer {
        interval: 1000; running: true; repeat: true;
        onTriggered: {
            var time = new Date()
            clockLabel.text = time.getHours() + "時" + time.getMinutes() + "分" + time.getSeconds() + "秒"
            if (new Date().getSeconds() % 2 == 0) {
                second2.play()
            } else {
                second1.play()
            }
        }
    }

    Audio {
        id: second1
        source: "second1.wav"
        volume: 0.1
    }
    Audio {
        id: second2
        source: "second2.wav"
        volume: 0.1
    }
}
