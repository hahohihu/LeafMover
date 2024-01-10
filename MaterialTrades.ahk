#Include "Utility.ahk"

class Kokkaupuni {
    static Open() {
        ; todo
    }
    
    static ConsumesGoodMaterial() {
        InputMaterials := Area.FromRaw(800, 200, 910, 300)
        Loop Files, "GoodMaterials\*"
        {
            if InputMaterials.ImageTest(A_LoopFileFullPath)
                return true
        }
        return false
    }

    static EnoughMaterials() {
        InputQuantities := Area.FromRaw(875, 215, 900, 275)
        return not InputQuantities.PixelTest(0x830808)
    }

    static ChangeAvailable() {
        RightButtonBrightSpot := Point(1580, 230)
        return not RightButtonBrightSpot.PixelTest(BackgroundBrown)
    }

    static TradePending() {
        LeftButtonBrightSpot := Point(1380, 230)
        return LeftButtonBrightSpot.PixelTest(BackgroundBrown)
    }

    static TradeComplete() {
        CheckArea := Area.FromRaw(1250, 220, 1280, 240)
        return CheckArea.PixelTest(CheckGreen)
    }

    static Trade() {
        RightButton := Point(1530, 230)
        LeftButton := Point(1330, 230)
        Failures := 0
        Loop 15 {
            if Failures >= 3 {
                return false
            }
            if (Kokkaupuni.ChangeAvailable() and Kokkaupuni.ConsumesGoodMaterial()) or not Kokkaupuni.EnoughMaterials() {
                RightButton.Click()
                Failures++
            } else {
                LeftButton.Click()
                While Kokkaupuni.TradePending() {
                    Sleep 50
                }
                LeftButton.Click()
                Failures := 0
            }
        }
        return true
    }
}

TradeMaterials() {
    ; Clicc 430, 660 ; wayland
    Clicc 1000, 680 ; torvalds
    return Kokkaupuni.Trade()
}
