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

class Stay extends Activity {
    Cooldown := 10000

    WithArea(Area) {
        this.Area := Area
        return this
    }

    WithCraftedSet(CraftedSet) {
        this.CraftedSet := CraftedSet
        return this
    }

    WithCooldown(Cooldown) {
        this.Cooldown := Cooldown
        return this
    }

    Act() {
        ; nothing
    }
}