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
        back.setChangeTime()
        //back.updateBack()
    }

    property bool muted: false
    property int timeCount: 0

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
        interval: 100; running: true; repeat: true;
        onTriggered: {
            update()
        }
    }

    Audio {
        id: second1
        source: "sounds/second1.wav"
        volume: 0.1
    }
    Audio {
        id: second2
        source: "sounds/second2.wav"
        volume: 0.1
    }

    function update() {
        if (timeCount % 10 == 0) {
            updateTime()
        }
        back.currentTime = getDayDeci()
        if (timeCount % 600 == 0) {
            back.updateBack()
            timeCount = 0
        } else timeCount++
        back.updateSun()
    }
    function updateTest() {
        if (back.currentTime < back.maxTime)
            back.currentTime += 50
        else
            back.currentTime = 0
        back.updateBack()
        back.updateSun()
    }

    function updateTime() {
        var time = new Date()
        clockLabel.text = (time.getHours() < 10 ? "0" + time.getHours() : time.getHours())  + ":" + (time.getMinutes() < 10 ? "0" + time.getMinutes() : time.getMinutes())
        if (!muted) {
            if (time.getSeconds() % 2 == 0) {
                second2.play()
            } else {
                second1.play()
            }
        }
    }

    function getDayDeci() {
        var time = new Date()
        return time.getHours() * 36000 + time.getMinutes() * 600 + time.getSeconds() * 10
    }
}
