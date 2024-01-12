#Include "Pets.ahk"
#Include "Areas.ahk"
#Include "Activity.ahk"

class MaterialFarming extends Activity {
    Area := Areas.DarkGlade

    Act() {
        LoadPetTeam(2)
        Clear
        Center
    }
}
