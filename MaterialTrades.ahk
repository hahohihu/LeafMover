#Include "Utility.ahk"

class MaterialTrades {
    static Open() {
        ; todo
    }
    
    ConsumesGoodMaterial() {
        InputMaterials := Area.FromRaw(800, 200, 910, 300)
        Loop Files, "GoodMaterials\*"
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

    Trade() {
        RightButton := Point(1530, 230)
        LeftButton := Point(1330, 230)
        ; Clicc 430, 660 ; wayland
        Clicc 1000, 680 ; torvalds
        Loop 70 {
            if (MaterialTrades.ChangeAvailable() and MaterialTrades.ConsumesGoodMaterial()) or not MaterialTrades.EnoughMaterials() {
                RightButton.Click()
            } else {
                LeftButton.Click()
                While MaterialTrades.TradePending() {
                    Sleep 50
                }
                LeftButton.Click()
            }
        }
    }
}