#Include "Utility.ahk"
#Include "Pets.ahk"
#Include "Activity.ahk"

class Trade {
    __New(Name, Cutoff := 100000) {
        this.Name := Name
        this.Cutoff := Cutoff
    }
}

class Trades extends Activity {
    Cooldown := 120000
    CraftedSet := 1
    PetTeam := 1
    Debug := false
    static DebugDir := "Debug/Trades/"
    static DebugGoodDir := Trades.DebugDir "Good/"
    static DebugBadDir := Trades.DebugDir "Bad/"

    __New(GoodTrades) {
        this.GoodTrades := GoodTrades
        this.Iterations := 100
    }

    Act() {
        Clear
        Trades.Open
        Trades.CollectAll
        Loop 150 {
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
        InputMaterials := Area.FromRaw(920, y1, 953, y2)
        if not Area.FromRaw(970, y1, 985, y2).PixelTest(White) {
            return false ; only triggers on small quantities
        }
        for trade in this.GoodTrades {
            if trade.Cutoff < this.Iterations {
                continue
            }
            Loop Files, "Trades\" trade.Name "*.png"
            {
                if InputMaterials.ImageSearch(&x, &y, "*15 " A_LoopFileFullPath)
                {
                    if this.Debug {
                        InputMaterials.SaveImage(Trades.DebugGoodDir GUID.Get() ".png")
                    }
                    return true
                }
            }
        }
        if this.Debug {
            InputMaterials.SaveImage(Trades.DebugBadDir GUID.Get() ".png")
        }
        return false
    }

    ; returns false if there are no more possible trades
    TradeOnce() {
        TradeBottom := Area.FromRaw(300, 712, 310, 782)
        ScrollUp 10
        yStart := 200
        yEnd := Trades.FindYEnd(yStart)
        if yEnd < 320 {
            return false
        }
        Iterations := 0
        while yStart < yEnd {
            BlueArrowSearchArea := Area.FromRaw(895, yStart, 896, yStart + 100)
            if not BlueArrowSearchArea.PixelSearch(&ax, &ay, 0x1ea7e1, 10) {
                break
            }
            ExpectedButton := Point(1490, ay + 10)
            if ExpectedButton.PixelTest(ActiveBeige) {
                if this.GoodTrade(ay - 8, ay + 22, &x, &y) {
                    ExpectedButton.Click()
                }
            } else if ExpectedButton.PixelTest(BackgroundBrown) {
                break
            }
            yStart := ay + 40
            Iterations++
        }
        this.Iterations := Iterations
        return true
    }
}

MakeCleanDir(Trades.DebugGoodDir)
MakeCleanDir(Trades.DebugBadDir)
