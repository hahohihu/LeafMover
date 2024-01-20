#Include "Utility.ahk"

class Areas {
    static Open() {
        ControlSend "v",, GameTitle
        Sleep 100
    }

    static OpenFavorites() {
        Areas.Open()
        Clicc 343, 870 ; Favorites
        Sleep 100
    }

    class Tower {
        Open() {
            Areas.OpenFavorites()
            ; Clicc 1533, 277 ; Max
            Clicc 1300, 230
        }
    }

    class Kokkaupuni {
        Open() {
            Areas.OpenFavorites()
            Clicc 1300, 330
        }
    }

    class CursedKokkaupuni {
        Open() {
            Areas.OpenFavorites()
            Clicc 1300, 445
        }
    }

    class DarkGlade {
        Open() {
            Areas.OpenFavorites()
            Clicc 1300, 531
        }
    }

    class DiceyMeadows {
        Open() {
            Areas.OpenFavorites()
            Clicc 1300, 660
        }
    }

    class CheesePub {
        Open() {
            Areas.OpenFavorites()
            Clicc 1300, 767
        }
    }

    class CursedHalloween {
        Open() {
            Areas.Open()
            Clicc 1562, 874
            Sleep 100
            Clicc 1294, 225
        }
    }

    class Any {
    }

    static Current := Areas.Any()
    static Filler := Areas.Any()

    static Goto(area) {
        if area is Areas.Any {
            if not (Areas.Filler is Areas.Any) {
                Areas.Goto(Areas.Filler)
            }
        } else if area != Areas.Current {
            Clear
            Areas.Current := area
            area.Open()
            Clear
        }
    }

    ; this area will be entered when "Any" tasks are in progress
    static SetFillerArea(area) {
        Areas.Filler := area
    }
}
