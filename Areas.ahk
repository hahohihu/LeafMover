#Include "Utility.ahk"

class Areas {
    static Open() {
        ControlSend "v",, GameTitle
        Sleep 100
        Clicc 343, 870 ; Favorites
    }

    static Kokkaupunki() {
        Clicc 1300, 514
    }

    static DarkGlade() {
        Clicc 1300, 626
    }
}
