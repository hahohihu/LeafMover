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
