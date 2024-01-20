^Esc:: ExitApp

CoordMode "Mouse", "Screen"

SetKeyDelay 0, 50

Title := "Daily Lives of My Countryside"
Game := GameController()

class GameController {
    Send(keys*) {
        for key in keys {
            ControlSend key,, Title
            Sleep 50
        }
    }
}

ReturnToMainMenu() {
    WinActivate Title
    Game.Send("x", "{Up}", "z", "{Down}", "z")
}

^M::ReturnToMainMenu