#Include "Utility.ahk"

class Areas {
    class FavoriteArea {
        Open() {
            ControlSend "v",, GameTitle
            Sleep 100
            Clicc 343, 870 ; Favorites
            Sleep 100
            this.favoriteLocation.Click()
            Sleep 100
        }
    }

    class Kokkaupuni extends Areas.FavoriteArea {
        favoriteLocation := Point(1300, 514)
    }

    class DarkGlade extends Areas.FavoriteArea {
        favoriteLocation := Point(1300, 626)
    }

    class CheesePub extends Areas.FavoriteArea {
        favoriteLocation := Point(1289, 756)
    }

    class DiceyMeadows {
        Open() {
            ControlSend "v",, GameTitle
            Sleep 100
            Clicc 500, 870 ; Leaf Galaxy
            Sleep 100
            Send "{WheelDown 8000}"
            Sleep 100
            Clicc 1300, 340
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
