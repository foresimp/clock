import QtQuick 2.9

Rectangle {
    id: back
    states: [
        State {
            property int time: 30 // 05:00
            property color color0: "#7084a5"
            property color color1: "#ada6be"
            property color color2: "#d4b0b5"
            property color color3: "#7084a5"
        },
        State {
            property int time: 36 // 06:00
            property color color0: "#7084a5"
            property color color1: "#ada6be"
            property color color2: "#d4b0b5"
            property color color3: "#7084a5"
        },
        State {
            property int time: 42 // 07:00
            property color color0: "#7084a5"
            property color color1: "#ada6be"
            property color color2: "#d4b0b5"
            property color color3: "#7084a5"
        },
        State {
            property int time: 72 // 12:00
            property color color0: "#0079ff"
            property color color1: "#0091ec"
            property color color2: "#a3ddff"
            property color color3: "#527e99"
        },
        State {
            property int time: 102 // 17:00
            property color color0: "#7084a5"
            property color color1: "#ada6be"
            property color color2: "#d4b0b5"
            property color color3: "#7084a5"
        },
        State {
            property int time: 108 // 18:00
            property color color0: "#226ba2"
            property color color1: "#0082d7"
            property color color2: "#f98010"
            property color color3: "#c8ceca"
        },
        State {
            property int time: 114 // 19:00
            property color color0: "#7084a5"
            property color color1: "#ada6be"
            property color color2: "#d4b0b5"
            property color color3: "#7084a5"
        },
        State {
            property int time: 144 // 00:00
            property color color0: "#001932"
            property color color1: "#102449"
            property color color2: "#48399e"
            property color color3: "#051637"
        }
    ]

    property int currentTime: 0
    property int maxTime: 144
    property int nextIndex: 0

    property int timeDiff: 0
    property int currentTimeDiff: 0
    property int preIndex: 0

    Rectangle {
        id: sky
        width: parent.width
        height: parent.height * 0.9
        anchors.top: parent.top
        gradient: Gradient {
            GradientStop { id: g0; position: 0.0; color: "#7084a5" }
            GradientStop { id: g1; position: 0.5; color: "#ada6be" }
            GradientStop { id: g2; position: 1.0; color: "#d4b0b5" }
        }
    }
    Rectangle {
        id: sea
        width: parent.width
        anchors.top: sky.bottom
        anchors.bottom: parent.bottom
    }

    function updateBack() {
        nextIndex = -1
        for (var i = 0; i < states.length; i++) {
            if (states[i].time >= currentTime){
                nextIndex = i
                break
            }
        }
        if (nextIndex == -1)
            nextIndex = 0
        if (states[nextIndex].time === currentTime) {
            g0.color = states[nextIndex].color0
            g1.color = states[nextIndex].color1
            g2.color = states[nextIndex].color2
            if (states.length < nextIndex + 2)
                nextIndex = 0
            else
                nextIndex++
        } else {
            if (nextIndex == 0) {
                timeDiff = maxTime - states[states.length - 1].time + states[nextIndex].time
                currentTimeDiff = currentTime < states[states.length - 1].time ? maxTime - states[states.length - 1].time + currentTime : currentTime - states[states.length - 1].time
                preIndex = states.length - 1
            } else {
                timeDiff = states[nextIndex].time - states[nextIndex - 1].time
                currentTimeDiff = currentTime - states[nextIndex - 1].time
                preIndex = nextIndex - 1
            }
            g0.color.r = (states[nextIndex].color0.r - states[preIndex].color0.r) / timeDiff * currentTimeDiff + states[preIndex].color0.r
            g0.color.g = (states[nextIndex].color0.g - states[preIndex].color0.g) / timeDiff * currentTimeDiff + states[preIndex].color0.g
            g0.color.b = (states[nextIndex].color0.b - states[preIndex].color0.b) / timeDiff * currentTimeDiff + states[preIndex].color0.b
            g1.color.r = (states[nextIndex].color1.r - states[preIndex].color1.r) / timeDiff * currentTimeDiff + states[preIndex].color1.r
            g1.color.g = (states[nextIndex].color1.g - states[preIndex].color1.g) / timeDiff * currentTimeDiff + states[preIndex].color1.g
            g1.color.b = (states[nextIndex].color1.b - states[preIndex].color1.b) / timeDiff * currentTimeDiff + states[preIndex].color1.b
            g2.color.r = (states[nextIndex].color2.r - states[preIndex].color2.r) / timeDiff * currentTimeDiff + states[preIndex].color2.r
            g2.color.g = (states[nextIndex].color2.g - states[preIndex].color2.g) / timeDiff * currentTimeDiff + states[preIndex].color2.g
            g2.color.b = (states[nextIndex].color2.b - states[preIndex].color2.b) / timeDiff * currentTimeDiff + states[preIndex].color2.b
            sea.color.r = (states[nextIndex].color3.r - states[preIndex].color3.r) / timeDiff * currentTimeDiff + states[preIndex].color3.r
            sea.color.g = (states[nextIndex].color3.g - states[preIndex].color3.g) / timeDiff * currentTimeDiff + states[preIndex].color3.g
            sea.color.b = (states[nextIndex].color3.b - states[preIndex].color3.b) / timeDiff * currentTimeDiff + states[preIndex].color3.b
        }
    }
}
