import QtQuick 2.9

Rectangle {
    id: back
    states: [
        State {
            property int timeM: 0 // 深夜
            property color color0: "#000000"
            property color color1: "#090c26"
            property color color2: "#241d4c"
            property color color3: "#0f1f3c"
        },
        State {
            property int timeM: 300 // 夜明け前
            property color color0: "#9ac2d6"
            property color color1: "#c9b3ab"
            property color color2: "#c4526d"
            property color color3: "#162f79"
        },
        State {
            property int timeM: 360 // 夜明け
            property color color0: "#aad4ff"
            property color color1: "#c0c8ce"
            property color color2: "#e0462f"
            property color color3: "#8093ff"
        },
        State {
            property int timeM: 420 // 夜明け後
            property color color0: "#aad4ff"
            property color color1: "#ede19e"
            property color color2: "#ffab2d"
            property color color3: "#7ab5ff"
        },
        State {
            property int timeM: 720 // 昼
            property color color0: "#0079ff"
            property color color1: "#0091ec"
            property color color2: "#a3ddff"
            property color color3: "#0091ec"
        },
        State {
            property int timeM: 1020 // 夕焼け前
            property color color0: "#2a83c7"
            property color color1: "#56aadf"
            property color color2: "#fedfc3"
            property color color3: "#56aadf"
        },
        State {
            property int timeM: 1080 // 夕焼け
            property color color0: "#2a83c7"
            property color color1: "#7aadc1"
            property color color2: "#ff772d"
            property color color3: "#0082d7"
        },
        State {
            property int timeM: 1140 // 夕焼け後
            property color color0: "#2670ad"
            property color color1: "#516e91"
            property color color2: "#a55276"
            property color color3: "#0a5687"
        }
    ]

    property int currentTime: 0
    property int maxTime: 863999
    property int nextIndex: 0

    property int timeDiff: 0
    property int currentTimeDiff: 0
    property int preIndex: 0

    property int sr: 0 // 日の出時間（分）
    property int c: 0 // 南中時間（分）
    property int ss: 0 // 日の入り時間（分）
    property int sunSpeedM: 6 // 太陽の速さ（分速）
    property int sunTop: (height - sea.height) * 2
    property int sunNormal: (height - sea.height) // 太陽のstateがnormalになる位置
    property int sunHides: (height - sea.height) * 1.6 // 太陽の下辺が画面上端と重なる位置
    property int sunAppear: (height - sea.height) * 0.43 // 太陽の上辺が水平線と重なる位置

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
    Sun {
        id: sun
        anchors.fill: parent
        voTweak: (width - height + sea.height) / -2 + (height - sea.height)
        Component.onCompleted: {
            gc0 = states[0].c0
            gc1 = states[0].c1
            gc2 = states[0].c2
            gc3 = states[0].c3
        }
    }
    Rectangle {
        id: sea
        width: parent.width
        anchors.top: sky.bottom
        anchors.bottom: parent.bottom
    }

    function updateBack() {
        var currentTimeM = Math.floor(currentTime / 600)
        var maxTimeM = Math.floor(maxTime / 600)
        nextIndex = -1
        for (var i = 0; i < states.length; i++) {
            if (states[i].timeM >= currentTimeM){
                nextIndex = i
                break
            }
        }
        if (nextIndex == -1)
            nextIndex = 0
        if (states[nextIndex].timeM === currentTimeM) {
            g0.color = states[nextIndex].color0
            g1.color = states[nextIndex].color1
            g2.color = states[nextIndex].color2
            sea.color = states[nextIndex].color3
            nextIndex = states.length < nextIndex + 2 ? 0 : nextIndex + 1
        } else {
            if (nextIndex == 0) {
                timeDiff = maxTimeM - states[states.length - 1].timeM + states[nextIndex].timeM
                currentTimeDiff = currentTimeM < states[states.length - 1].timeM ? maxTimeM - states[states.length - 1].timeM + currentTimeM : currentTimeM - states[states.length - 1].timeM
                preIndex = states.length - 1
            } else {
                timeDiff = states[nextIndex].timeM - states[nextIndex - 1].timeM
                currentTimeDiff = currentTimeM - states[nextIndex - 1].timeM
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

    function updateSun() {
        var from, to
        var srStartTimeM = sr - sunAppear / sunSpeedM
        var ssStartTimeM = ss - (sunTop - sunAppear) / sunSpeedM
        if (currentTime >= srStartTimeM * 600 && currentTime < ssStartTimeM * 600) {
            sun.vo = (currentTime - srStartTimeM * 600) * (sunSpeedM / 600)
            from = 0; to = 1
        }
        if (currentTime >= ssStartTimeM * 600 || currentTime < srStartTimeM * 600) {
            sun.vo = (currentTime - ssStartTimeM * 600) * -(sunSpeedM / 600) + sunTop
            from = 2; to = 1
        }
        sun.opacity = sun.vo < 0 || sun.vo > sunTop ? 0 : (sun.vo <= sunAppear ? sun.vo / sunAppear : (sun.vo >= sunHides ? (sunTop - sun.vo) / (sunTop - sunHides) : 1))
        var i = sun.vo < sunAppear ? 0 : (sun.vo > sunNormal ? 1 : (sun.vo - sunAppear) / (sunNormal - sunAppear))
        sun.gc0.r = (sun.states[to].c0.r - sun.states[from].c0.r) * i + sun.states[from].c0.r
        sun.gc0.g = (sun.states[to].c0.g - sun.states[from].c0.g) * i + sun.states[from].c0.g
        sun.gc0.b = (sun.states[to].c0.b - sun.states[from].c0.b) * i + sun.states[from].c0.b
        sun.gc0.a = (sun.states[to].c0.a - sun.states[from].c0.a) * i + sun.states[from].c0.a
        sun.gc1.r = (sun.states[to].c1.r - sun.states[from].c1.r) * i + sun.states[from].c1.r
        sun.gc1.g = (sun.states[to].c1.g - sun.states[from].c1.g) * i + sun.states[from].c1.g
        sun.gc1.b = (sun.states[to].c1.b - sun.states[from].c1.b) * i + sun.states[from].c1.b
        sun.gc1.a = (sun.states[to].c1.a - sun.states[from].c1.a) * i + sun.states[from].c1.a
        sun.gc2.r = (sun.states[to].c2.r - sun.states[from].c2.r) * i + sun.states[from].c2.r
        sun.gc2.g = (sun.states[to].c2.g - sun.states[from].c2.g) * i + sun.states[from].c2.g
        sun.gc2.b = (sun.states[to].c2.b - sun.states[from].c2.b) * i + sun.states[from].c2.b
        sun.gc2.a = (sun.states[to].c2.a - sun.states[from].c2.a) * i + sun.states[from].c2.a
        sun.gc3.r = (sun.states[to].c3.r - sun.states[from].c3.r) * i + sun.states[from].c3.r
        sun.gc3.g = (sun.states[to].c3.g - sun.states[from].c3.g) * i + sun.states[from].c3.g
        sun.gc3.b = (sun.states[to].c3.b - sun.states[from].c3.b) * i + sun.states[from].c3.b
        sun.gc3.a = (sun.states[to].c3.a - sun.states[from].c3.a) * i + sun.states[from].c3.a
    }

    function setChangeTime(){
        var times = getSunriseSunsetTime()
        sr = times[0] // 日の出
        c = times[1] // 南中
        ss = times[2] // 日の入り
        states[1].timeM = sr - 60
        states[2].timeM = sr
        states[3].timeM = sr + 60
        states[4].timeM = c
        states[5].timeM = ss - 60
        states[6].timeM = ss
        states[7].timeM = ss + 60
    }

    function getSunriseSunsetTime() {
        // ***現在の年・月・日を取得***
        var currentDate = new Date()
        var currentYear = currentDate.getFullYear()
        var currentMonth = currentDate.getMonth()
        var currentDay = currentDate.getDate()

        // ***1月1日からの日数***
        var dt1 = new Date(currentYear, currentMonth, currentDay)
        var dt2 = new Date(currentYear, 0, 1)
        var diff = dt1 - dt2
        var days = diff / 86400000

        // ***日の出・日の入り時刻を取得***
        var lon = 140.725157 // 軽度
        var lat = 42.589130 // 緯度
        var latR = lat * Math.PI / 180
        var day1 = 2 * Math.PI * (days - 81.5) / 365
        var day2 = 2 * Math.PI * (days - 3) / 365
        // 均時差
        var timeEquation1 = -7.37 * Math.sin(day2)
        var timeEquation2 = 9.86 * Math.sin(2 * day1)
        var timeEquation = timeEquation1 + timeEquation2
        // 太陽の赤緯
        var sunDeclination = 0.4082 * Math.sin(day1)
        // 昼間の時間
        var dayTimeMin = 1440 * (1 - Math.acos(Math.tan(sunDeclination) * Math.tan(latR)) / Math.PI)
        // 補正値
        var currectionMin = 0.8502 * 4 / Math.sqrt(1 - Math.sin(latR) * Math.sin(latR) / (Math.acos(sunDeclination) * Math.acos(sunDeclination)))
        // 南中
        var colminationTime = 720 - timeEquation + 4 * (135 - lon)
        //日の出時刻　【午前0時からの通し時間（分）】
        var sunriseMin = Math.ceil(colminationTime - dayTimeMin / 2 - currectionMin)
        //日の入り時刻　【午前0時からの通し時間（分）】
        var sunsetMin = Math.ceil(colminationTime + dayTimeMin / 2 - currectionMin)
        return [sunriseMin, Math.ceil(colminationTime), sunsetMin]
    }
}
