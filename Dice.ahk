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
        Clicc 890, 451
    }
}

class DiceFarm extends Activity {
    Cooldown := 60000
    Area := Areas.DiceyMeadows()

    Act() {
        ScreenScan
    }
}

