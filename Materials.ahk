#Include "Utility.ahk"

InputMaterials := Area.FromRaw(800, 200, 910, 300)
InputQuantities := Area.FromRaw(875, 215, 900, 275)

ConsumesGoodMaterial() {
    Loop Files, "Matches\*"
    {
        if InputMaterials.ImageTest(A_LoopFileFullPath)
            return true
    }
    return false
}

NotEnoughMaterials() {
    NotEnoughRed := 0x830808
    return InputQuantities.PixelTest(NotEnoughRed)
}

MakeEssences() {
    Clicc 800, 905 ; alchemy 
    Clicc 546, 878 ; Essences
    Clicc 1255, 230 ; Cosmic
    Clicc 1255, 435 ; Leaf
}

BadTrade() {
    return ConsumesGoodMaterial() or NotEnoughMaterials()
}

RightButton := Point(1530, 230)
RightButtonBrightSpot := Point(1580, 230)
LeftButton := Point(1330, 230)
LeftButtonBrightSpot := Point(1380, 230)

ChangeAvailable() {
    return not RightButtonBrightSpot.PixelTest(BackgroundBrown)
}

TradePending() {
    CheckArea := Area.FromRaw(1250, 220, 1280, 240)
    return CheckArea.PixelTest(CheckGreen)
        or LeftButtonBrightSpot.PixelTest(BackgroundBrown)
}

MakeTrades() {
    Clear
    ; Clicc 430, 660 ; wayland
    Clicc 1000, 680 ; torvalds
    Loop 70 {
        if ChangeAvailable() and BadTrade() and not TradePending() {
            RightButton.Click()
        } else {
            LeftButton.Click()
        }
        Sleep 500
    }
}