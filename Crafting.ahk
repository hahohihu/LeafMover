#Include "Utility.ahk"
#Include "Activity.ahk"

class Crafting extends Activity {
    Stop := Point(590, 560)
    BarY := 660
    Bar := Area.FromRaw(260, this.BarY, 1620, this.BarY + 1)
    MiddleX := 935

    Act() {
        Clicc 755, 900 ; crafting
        SetBoolTimer &TimesUp, 30000
        While not TimesUp {
            a := this.FindWhiteX()
            da := Abs(this.MiddleX - a)
            Sleep 20
            b := this.FindWhiteX()
            db := Abs(this.MiddleX - b)
            offset := 250
            if db > da or db < offset {
                Sleep 100
                continue
            }
            if b < this.MiddleX {
                x1 := this.MiddleX - offset
                x2 := this.MiddleX
            } else {
                x1 := this.MiddleX
                x2 := this.MiddleX + offset
            }
            target := Area.FromRaw(x1, this.BarY, x2, this.BarY + 1)
            while not target.PixelTest(White) {
            }
            this.Stop.Click()
        }
    }

    FindWhiteX() {
        while not this.Bar.PixelSearch(&x, &y, White) {
            Sleep 1
        }
        return x
    }
}


