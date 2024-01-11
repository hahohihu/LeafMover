#Include "Utility.ahk"
#Include "Activity.ahk"

class MaterialTrades extends Activity {
    Area := Areas.Kokkaupuni
    Cooldown := 120000

    __New(choices) {
        this.choices := choices
    }

    Act() {
        MerchantChoice := 1
        Loop this.choices.Length {
            if (MerchantChoice > this.choices.Length) {
                MerchantChoice := 1
            }
            Clear
            this.choices[MerchantChoice].merchantLocation.Click()
            MaterialTrades.Trade()
            MerchantChoice++
        }
    }
    
    static ConsumesGoodMaterial() {
        InputMaterials := Area.FromRaw(800, 200, 910, 300)
        Loop Files, "GoodMaterials\*"
        { 
            ; todo - seem to have false positives ; false negatives are preferable
            ; disabled for now - not a big difference in conversion ratio
            if InputMaterials.ImageTest(A_LoopFileFullPath) {
                Msg "Found: " A_LoopFileFullPath
                return true
            }
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
        Loop 10 {
            if not MaterialTrades.EnoughMaterials() {
                if MaterialTrades.ChangeAvailable() {
                    RightButton.Click()
                } else {
                    return false
                }
            } else {
                LeftButton.Click()
                While MaterialTrades.TradePending() {
                    Sleep 500
                }
                LeftButton.Click()
            }
        }
        return true
    }
}
