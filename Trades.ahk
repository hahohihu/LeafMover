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

MAX_Y_END := 700
FindYEnd(start) {
    activeArea := Area.FromRaw(1300, start, 1330, 850)
    if activeArea.PixelSearch(&x, &y, QuitRed, 10) {
        return y - 40
    } else {
        return MAX_Y_END
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

; returns true if there may be more trades
StartTrades() {
    ScrollBottom := Point(1635, 778)
    ScrollToTop
    yStart := 250
    yEnd := FindYEnd(yStart)
    if yEnd < 320 {
        return false
    }
    while yStart < yEnd {
        if GoodTrade(yStart, yStart + 80, &x, &y) {
            ExpectedButtonArea := Area.FromRaw(1500, y - 10, 1550, y + 10)
            if ExpectedButtonArea.PixelSearch(&bx, &by, ActiveBeige, 5) {
                Clicc(bx, by)
            }
            yStart := y + 20
        } else if ScrollBottom.PixelTest(ActiveBeige) or yEnd < MAX_Y_END {
            yStart += 75
        } else {
            Send "{WheelDown}"
            yEnd := FindYEnd(yStart)
        }
    }
    return true
}

TakeAllTrades() {
    Clear
    Trades
    Loop 15 {
        CollectAll
        Refresh
        if not StartTrades() {
            break
        }
        Sleep 200
    }
}
