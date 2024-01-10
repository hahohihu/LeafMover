#Include "Utility.ahk"

Trades() {
    ControlSend "y", , GameTitle
}

Refresh() {
    Clicc 470, 820
}

GoodTrade(&x, &y) {
    InputMaterials := Area.FromRaw(910, 250, 960, 815)
    Loop Files, "Trades\*"
    {
        if InputMaterials.ImageSearch(&x, &y, "*4 " A_LoopFileFullPath) {
            MsgBox "Found " A_LoopFileFullPath " at " x ", " y
            return true
        }
    }
    Msgbox "Not found"
    return false
}

WinActivate GameTitle
Clear
Trades
if GoodTrade(&x, &y) {
    ExpectedButtonArea := Area.FromRaw(1440, y - 40, 1500, y + 20)
    if ExpectedButtonArea.PixelSearch(&bx, &by, 0xfff1d2, 5) {
        Clicc(bx, by)
        MsgBox "Clicked " bx ", " by
    } else {
        ; wheel down todo
    }
}