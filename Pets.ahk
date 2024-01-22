#Include "Utility.ahk"

class Pets {
    static OpenTeams() {
        Clicc 500, 53
        Clicc 544, 872
    }

    static _LoadTeam(n) {
        Pets.OpenTeams
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

    static Any := 0
    static Current := Pets.Any

    static LoadTeam(n) {
        if n != Pets.Any and n != Pets.Current {
            Clear
            Pets._LoadTeam(n)
            Pets.Current := n
            Clear
        }
    }
}
