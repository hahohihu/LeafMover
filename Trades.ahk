#Include "Utility.ahk"
#Include "Pets.ahk"
#Include "Activity.ahk"

class Trade {
    __New(Name, Quantity) {
        this.Name := Name
        This.Quantity := Quantity
    }
}

class Trades extends Activity {
    Cooldown := 120000

    __New(GoodTrades) {
        this.GoodTrades := GoodTrades
    }

    Act() {
        LoadPetTeam(1)
        LoadPetTeam(1) ; redundant in case of pause from saving
        Clear
        Trades.Open
        Loop 50 {
            Trades.CollectAll
            Trades.Refresh
            if not this.TradeOnce() {
                break
            }
        }
    }

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

    GoodTrade(y1, y2, &x, &y) {
        InputMaterials := Area.FromRaw(910, y1, 960, y2)
        for trade in this.GoodTrades {
            Loop Files, "Trades\" trade.Name "*.png"
            {
                if InputMaterials.ImageSearch(&x, &y, "*10 " A_LoopFileFullPath)
                    and Area.FromRaw(1000, y - 10, 1050, y + 10).PixelTest(White) ; at least 4 digits
                {
                    return true
                }
            }
        }
        return false
    }

    ; returns true if there may be more trades
    TradeOnce() {
        ScrollBottom := Point(1635, 778)
        ScrollUp 10
        yStart := 250
        yEnd := Trades.FindYEnd(yStart)
        if yEnd < 320 {
            return false
        }
        while yStart < yEnd {
            if this.GoodTrade(yStart, yStart + 80, &x, &y) {
                ExpectedButtonArea := Area.FromRaw(1500, y - 10, 1550, y + 10)
                if ExpectedButtonArea.PixelSearch(&bx, &by, ActiveBeige, 5) {
                    Clicc(bx, by)
                }
                yStart := y + 20
            } else if ScrollBottom.PixelTest(ActiveBeige) or yEnd < Trades.MAX_Y_END {
                yStart += 75
            } else {
                Send "{WheelDown}"
                yStart += 5 ; to guarantee progress
                yEnd := Trades.FindYEnd(yStart)
            }
        }
        return true
    }
}
