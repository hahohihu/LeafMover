#Include "Pets.ahk"
#Include "Areas.ahk"
#Include "Activity.ahk"

class Witch extends Activity {
    Area := Areas.CursedKokkaupuni()
    Cooldown := 157000
    CraftedSet := 4
    PetTeam := 1

    Act() {
        WaitForBossDeath()
    }
}

class Centaur extends Activity {
    Area := Areas.ExlatedBridge()
    Cooldown := 180000
    CraftedSet := 3
    PetTeam := 3

    Act() {
        WaitForBossDeath()
    }
}

class VileCreature extends Activity {
    Area := Areas.VilewoodCemetery()
    Cooldown := 180000
    CraftedSet := 3
    PetTeam := 3

    Act() {
        WaitForBossDeath()
        ScreenScan
    }
}

class SpamVortex extends Activity {
    Area := Areas.CheesePub()
    Cooldown := 30000
    CraftedSet := 2

    Act() {
        loop 20 {
            Clicc 555, 50 ; Artifacts
            ; assume bottom
            Clicc 1272, 366
            Center.Move()
            Sleep 2500
            this.Area.Open()
            Clear
        }
    }
}