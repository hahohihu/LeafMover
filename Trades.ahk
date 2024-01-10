#Include "Utility.ahk"

class Trades {
    static Open() {
        ControlSend "y", , GameTitle
    }

    static Refresh() {
        Clicc 470, 820
    }

    static CollectAll() {
        Clicc 1500, 820
    }

    static MAX_Y_END := 700
    static FindYEnd(start) {
        activeArea := Area.FromRaw(1300, start, 1330, 850)
        if activeArea.PixelSearch(&x, &y, QuitRed, 10) {
            return y - 40
        } else {
            return Trades.MAX_Y_END
        }
    }

    static GoodTrade(y1, y2, &x, &y) {
        InputMaterials := Area.FromRaw(910, y1, 960, y2)
        Loop Files, "Trades\*"
        {
            if InputMaterials.ImageSearch(&x, &y, "*10 " A_LoopFileFullPath) {
                ; MsgBox "Found " A_LoopFileFullPath " at " x ", " y
                return true
            }
        }
        return false
    }

    ; returns true if there may be more trades
    static StartPage() {
        ScrollBottom := Point(1635, 778)
        ScrollUp 4
        yStart := 250
        yEnd := Trades.FindYEnd(yStart)
        if yEnd < 320 {
            return false
        }
        while yStart < yEnd {
            if Trades.GoodTrade(yStart, yStart + 80, &x, &y) {
                ExpectedButtonArea := Area.FromRaw(1500, y - 10, 1550, y + 10)
                if ExpectedButtonArea.PixelSearch(&bx, &by, ActiveBeige, 5) {
                    Clicc(bx, by)
                }
                yStart := y + 20
            } else if ScrollBottom.PixelTest(ActiveBeige) or yEnd < Trades.MAX_Y_END {
                yStart += 75
            } else {
                Send "{WheelDown}"
                yEnd := Trades.FindYEnd(yStart)
            }
        }
        return true
    }

    static TakeAllTrades() {
        Clear
        Trades.Open
        Loop 15 {
            Trades.CollectAll
            Trades.Refresh
            if not Trades.StartPage() {
                break
            }
            Sleep 200
        }
    }
}