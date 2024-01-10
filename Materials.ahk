#Include "Pets.ahk"

class Kokkaupunki {
    static Open() {
        ; todo
    }

    static Farm() {
        Clear
        LoadPetTeam(2)
        ScreenScan
    }
}

FarmMaterials() {
    Kokkaupunki.Farm()
}
