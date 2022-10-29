import QtQuick 2.9
import QtGraphicalEffects 1.15

Item {
    states: [
        State {
            name: "sunrise"
            property color c0: Qt.rgba(0.992, 0.906, 0.024)
            property color c1: Qt.rgba(0.984, 0.671, 0, 0.8)
            property color c2: Qt.rgba(0.984, 0.671, 0, 0.4)
            property color c3: Qt.rgba(0.984, 0.671, 0, 0.2)
        },
        State {
            name: "normal"
            property color c0: Qt.rgba(1, 1, 1, 0.8)
            property color c1: Qt.rgba(1, 1, 1, 0.5)
            property color c2: Qt.rgba(1, 1, 1, 0.2)
            property color c3: Qt.rgba(1, 1, 1, 0)
        },
        State {
            name: "sunset"
            property color c0: Qt.rgba(0.992, 0.906, 0.024)
            property color c1: Qt.rgba(0.984, 0.671, 0, 0.8)
            property color c2: Qt.rgba(0.984, 0.671, 0, 0.4)
            property color c3: Qt.rgba(0.984, 0.671, 0, 0.2)
        }
    ]
    property color gc0
    property color gc1
    property color gc2
    property color gc3

    property int voTweak: 0
    property int vo: -1000

    RadialGradient {
        id: rg
        width: parent.width
        height: width
        verticalOffset: -vo + voTweak
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ffffff" }
            GradientStop { position: 0.02; color: "#ffffff" }
            GradientStop { position: 0.03; color: gc0 }
            GradientStop { position: 0.07; color: gc1 }
            GradientStop { position: 0.15; color: gc2 }
            GradientStop { position: 0.25; color: gc3 }
            GradientStop { position: 0.4; color: "#00000000" }
        }
    }
}
