#Include "Utility.ahk"

ConsumesGoodMaterial() {
    InputMaterials := Area.FromRaw(800, 200, 910, 300)
    Loop Files, "Matches\*"
    {
        if InputMaterials.ImageTest(A_LoopFileFullPath)
            return true
    }
    return false
}

EnoughMaterials() {
    InputQuantities := Area.FromRaw(875, 215, 900, 275)
    return not InputQuantities.PixelTest(0x830808)
}

MakeEssences() {
    Clear
    Clicc 800, 905 ; alchemy 
    Clicc 546, 878 ; Essences
    Clicc 1255, 230 ; Cosmic
    Clicc 1255, 435 ; Leaf
}

ChangeAvailable() {
    RightButtonBrightSpot := Point(1580, 230)
    return not RightButtonBrightSpot.PixelTest(BackgroundBrown)
}

TradePending() {
    LeftButtonBrightSpot := Point(1380, 230)
    return LeftButtonBrightSpot.PixelTest(BackgroundBrown)
}

TradeComplete() {
    CheckArea := Area.FromRaw(1250, 220, 1280, 240)
    return CheckArea.PixelTest(CheckGreen)
}

MakeTrades() {
    RightButton := Point(1530, 230)
    LeftButton := Point(1330, 230)
    Clear
    ; Clicc 430, 660 ; wayland
    Clicc 1000, 680 ; torvalds
    Loop 70 {
        if (ChangeAvailable() and ConsumesGoodMaterial()) or not EnoughMaterials() {
            RightButton.Click()
        } else {
            LeftButton.Click()
            While TradePending() {
                Sleep 50
            }
            LeftButton.Click()
        }
    }
}