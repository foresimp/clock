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
    color: "black"

    onVisibilityChanged: {
        if (visibility == Qt.WindowMaximized) {
            mainWindow.showFullScreen()
        }
    }

    Component.onCompleted: {
        update()
    }

    property bool muted: false
    property int i: 60

    Back {
        id: back
        width: parent.width
        height: parent.height
        anchors.top: parent.top
    }

    Label {
        id: clockLabel
        y: (mainWindow.height - height) / 2
        text: "00:00"
        color: "white"
        font.pointSize: mainWindow.width / 5
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
            muted = !muted
            if (muted) {
                text = "M"
            } else {
                text = "S"
            }
        }
    }

    Timer {
        interval: 200; running: true; repeat: true;
        onTriggered: {
            if (back.currentTime < 144)
                back.currentTime++
            else
                back.currentTime = 0
            back.updateBack()
            //update()
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

    function update() {
        var time = new Date()
        clockLabel.text = (time.getHours() < 10 ? "0" + time.getHours() : time.getHours())  + ":" + (time.getMinutes() < 10 ? "0" + time.getMinutes() : time.getMinutes())
        if (!muted) {
            if (new Date().getSeconds() % 2 == 0) {
                second2.play()
            } else {
                second1.play()
            }
        }
        back.currentTime = getDayMinute()
        if (i >= 60) {
            back.updateBack()
            i = 0
        } else i++
    }

    function getDayMinute() {
        var time = new Date()
        return (time.getHours()) * 6 + Math.floor(time.getMinutes() / 10)
    }
}
