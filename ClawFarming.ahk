#Include "Activity.ahk"

class ClawFarming extends Activity {
    Area := Areas.CheesePub()

    static ClawMachine() {
        Clicc 472, 400 ; claw machine
    }

    Act() {
        ; requires autostart enabled
        ClawFarming.ClawMachine
        SetBoolTimer &TimesUp, 30000
        While not TimesUp {
            Gem := ClawFarming.LocateGem()
            if not Gem {
                ControlSend "{Esc}",, GameTitle
                ClawFarming.ClawMachine
            } else {
                ClawFarming.ReleaseClaw(Gem.x - 10)
            }
            
        }
    }

    static ReleaseClaw(x) {
        ExpectedClawArea := Area.FromRaw(x - 5, 230, x + 5, 330)
        TotalClawArea := Area.FromRaw(250, 230, 1600, 330)
        ClawGrey := 0x8b9bb4
        ClawShadow := 0x262b44
        Loop 2000 {
            if ExpectedClawArea.PixelTest(ClawShadow, 10) {
                Center
                Sleep 2000
                while TotalClawArea.PixelTest(GemRed, 20) {
                    Sleep 100
                }
                return
            }
        }
    }

    static LocateGem() {
        Rewards := Area.FromRaw(310, 477, 1540, 715)
        if not Rewards.PixelSearch(&x, &y, GemRed, 20) {
            return
        }
        ExpectedGem := Area.FromRaw(x - 25, y - 25, x + 25, y + 25)
        if ExpectedGem.PixelTest(GemDarkRed, 20)
            and ExpectedGem.PixelTest(GemShadow, 20)
            and ExpectedGem.PixelTest(White) {
                return Point(x, y)
        }
    }
}