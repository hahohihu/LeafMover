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
            Item := ClawFarming.LocateGem()
            if not Item {
                ControlSend "{Esc}",, GameTitle
                ClawFarming.ClawMachine
            } else {
                ClawFarming.ReleaseClaw(Item)
            }
            
        }
    }

    static ReleaseClaw(Item) {
        ExpectedClawArea := Area.FromRaw(Item.x - 15, 230, Item.x - 5, 330)
        TotalClawArea := Area.FromRaw(250, 230, 1600, 330)
        ClawGrey := 0x8b9bb4
        ClawShadow := 0x262b44
        Loop 2000 {
            if ExpectedClawArea.PixelTest(ClawShadow, 10) {
                Center.Click()
                Sleep 2000
                while TotalClawArea.PixelTest(Item.Color, 20) {
                    Sleep 100
                }
                return
            }
        }
    }

    static LocateGem() {
        HalloweenOrange := 0xff9e13
        HalloweenYellow := 0xffff23
        HalloweenGreen := 0x6cd820
        Searches := [
            [GemRed, GemDarkRed, GemShadow],
            [HalloweenOrange, HalloweenYellow, HalloweenGreen]
        ]
        Rewards := Area.FromRaw(310, 477, 1540, 715)
        for search in Searches {
            if not Rewards.PixelSearch(&x, &y, search[2], 20) {
                continue
            }
            ExpectedItem := Area.FromRaw(x - 25, y - 25, x + 25, y + 25)
            if ExpectedItem.PixelTest(search[2], 20)
                and ExpectedItem.PixelTest(search[3], 20)
                and ExpectedItem.PixelTest(White) 
            {
                Item := Point(x, y)
                Item.Color := search[1]
                return Item
            }
        }
    }
}