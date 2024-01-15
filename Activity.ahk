#Include "Areas.ahk"
#Include "CraftedSet.ahk"

class Activity {
    Cooldown := 1500
    Area := Areas.Any()
    CraftedSet := CraftedLeaves.Any
    Act() {
        throw Error("TODO")
    }
}

class GotoFillerArea extends Activity {
    Cooldown := 10000

    Act() {
        ; nothing - just trigger going back to default area
    }
}