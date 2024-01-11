#Include "Utility.ahk"
#Include "Activity.ahk"

class MaterialTrades extends Activity {
    Area := Areas.Kokkaupuni
    MerchantChoice := 1

    __New(choices) {
        this.choices := choices
        this.failures := choices.Clone()
        Loop this.failures.Length {
            this.failures[A_Index] := 0
        }
    }

    Act() {
        this.Cooldown := 500
        FAILURE_INC := 2
        WinActivate GameTitle
        Clear
        Loop this.choices.Length * FAILURE_INC  * 2 / 3 {
            if (this.MerchantChoice > this.choices.Length) {
                this.MerchantChoice := 1
            }
            if (this.failures[this.MerchantChoice] > 0) {
                this.failures[this.MerchantChoice]--
                this.MerchantChoice++
            } else {
                this.choices[this.MerchantChoice].merchantLocation.Click()
                if not MaterialTrades.Trade() {
                    this.failures[this.MerchantChoice] := FAILURE_INC
                }
                this.MerchantChoice++
                Sleep 800
                return
            }
        }
        this.Cooldown := 60000
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
        Loop 60 {
            if not MaterialTrades.ChangeAvailable() and not MaterialTrades.EnoughMaterials() {
                return false
            }
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
        return true
    }
}
