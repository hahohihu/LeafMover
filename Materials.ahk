#Include "Pets.ahk"

class Kokkaupunki {
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
    Kokkaupunki.Farm()
}
