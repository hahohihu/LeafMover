#Include "Utility.ahk"

class Pyramid {
    static OpenInner() {
        ControlSend "v",, GameTitle
        Sleep 100
        ControlSend "{Space}",, GameTitle
        Sleep 100
    }
}