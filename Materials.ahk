#Include "Pets.ahk"
#Include "Areas.ahk"
#Include "Activity.ahk"

class MaterialFarming extends Activity {
    Area := Areas.DarkGlade()
    Cooldown := 30000

    Act() {
        LoadPetTeam(2)
    }
}

class Witch extends Activity {
    Area := Areas.CursedKokkaupuni()
    Cooldown := 180000
    Count := 0

    Act() {
        this.Count++
        Log("Witch iteration: " this.Count)
        WitchBar := Area.FromRaw(955, 200, 956, 250)
        Sleep 10000
        while WitchBar.PixelTest(AttackTeal) {
            Sleep 1000
        }
    }
}
