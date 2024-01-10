#Include "Pets.ahk"

class DarkGlade {
    static Open() {
        ; todo
    }

    static Farm() {
        LoadPetTeam(2)
        Clear
        ScreenScan
    }
}

FarmMaterials() {
    DarkGlade.Farm()
}
