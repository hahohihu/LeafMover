#Include "Activity.ahk"

class CursedHalloween extends Activity {
    Cooldown := 180000
    Area := Areas.CursedHalloween()

    Act() {
        Clicc 962, 903 ; event shop
        Clicc 567, 876 ; Halloween
        Clicc 1200, 541 ; Weakness
        Clicc 1200, 647 ; bonus curses
        Clear
        if WaitForBossDeath() {
            Cooldown := Max(180000, this.Cooldown / 2)
        } else {
            Cooldown := this.Cooldown * 2
        }
    }
}
