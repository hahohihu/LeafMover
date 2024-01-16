#Include "Utility.ahk"
#Include "Activity.ahk"

class MaterialTrades extends Activity {
    Area := Areas.Kokkaupuni()
    Cooldown := 10000

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
            this.ModulateCooldown(MaterialTrades.Trade())
            MerchantChoice++
        }
    }
    
    static ConsumesGoodMaterial() {
        InputMaterials := Area.FromRaw(800, 200, 910, 300)
        Loop Files, "GoodMaterials\*"
        { 
            if InputMaterials.ImageTest("*10 " A_LoopFileFullPath) {
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
        Loop 50 {
            if MaterialTrades.TradePending() {
                RightButton.Click()
            } else if not MaterialTrades.EnoughMaterials() {
                if MaterialTrades.ChangeAvailable() {
                    RightButton.Click()
                } else {
                    return false
                }
            } else if MaterialTrades.ConsumesGoodMaterial() and MaterialTrades.ChangeAvailable() {
                RightButton.Click()
            } else {
                LeftButton.Click()
                Loop 20 {
                    if not MaterialTrades.TradePending() {
                        break
                    }
                    Sleep 200
                }
                LeftButton.Click()
            }
            Sleep 100
        }
        return true
    }
}
