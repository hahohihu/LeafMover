#Include "Activity.ahk"
#Include "Utility.ahk"

class Dice {
    static Open() {
        Clicc 905, 900
    }
}

class DiceRoll extends Activity {
    Cooldown := 30000

    Act() {
        Dice.Open()
        Clicc 530, 872 ; Battlefield
        Clicc 890, 451 ; Roll
        Clicc 1181, 300 ; Next
    }
}

class DiceFarm extends Activity {
    Cooldown := 60000
    Area := Areas.DiceyMeadows()

    Act() {
        Sleep 1000
        ScreenScan
    }
}
