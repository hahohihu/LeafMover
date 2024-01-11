#Include "Utility.ahk"

class Areas {
    static Open(area) {
        ControlSend "v",, GameTitle
        Sleep 100
        Clicc 343, 870 ; Favorites
        Sleep 100
        area.favoriteLocation.Click()
        Sleep 100
    }

    class Kokkaupuni {
        static favoriteLocation := Point(1300, 514)
    }

    class DarkGlade {
        static favoriteLocation := Point(1300, 626)
    }

    class CheesePub {
        static favoriteLocation := Point(1289, 756)
    }

    class Any {
    }
}
