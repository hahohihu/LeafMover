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
        Success := WaitForBossDeath()
        this.ModulateCooldown(Success)
        if not Success {
            ToolTip "Failed Pumpkin boss!"
        }
    }
}
