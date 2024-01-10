#Include "Utility.ahk"

class Pets {
    static OpenTeams() {
        Clicc 444, 53
        Clicc 544, 872
    }

    static LoadTeam(n) {
        switch n {
            case 1:
                y := 425
            case 2:
                y := 525
            case 3:
                y := 625
        }
        Clicc 350, y
    }
}

LoadPetTeam(n) {
    Pets.OpenTeams
    Pets.LoadTeam(n)
}