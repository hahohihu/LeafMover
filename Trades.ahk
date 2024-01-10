#Include "Utility.ahk"

Trades() {
    ControlSend "y", , GameTitle
}

Refresh() {
    Clicc 470, 820
}

CollectAll() {
    Clicc 1500, 820
}

ScrollToTop() {
    Loop 4 {
        Send "{WheelUp}"
        Sleep 50
    }
}

GoodTrade(y1, y2, &x, &y) {
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

StartTrades() {
    ScrollBottom := Point(1635, 778)
    ScrollToTop
    yBound := 250
    while yBound < 700 {
        if GoodTrade(yBound, yBound + 80, &x, &y) {
            ExpectedButtonArea := Area.FromRaw(1500, y - 10, 1550, y + 10)
            if ExpectedButtonArea.PixelSearch(&bx, &by, ActiveBeige, 5) {
                Clicc(bx, by)
            } else {
                ; MsgBox "Couldn't start " yBound
            }
        }
        if ScrollBottom.PixelTest(ActiveBeige) {
            yBound += 75
        } else {
            Send "{WheelDown}"
            yBound += 5
        }
    }
}

TradeOnce() {
    CollectAll
    Refresh
    StartTrades
    Sleep 200
}

WinActivate GameTitle
Clear
Trades
Loop 4 {
    TradeOnce
}