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
    Cooldown := 157000
    CraftedSet := 4

    Act() {
        WaitForBossDeath()
    }
}
