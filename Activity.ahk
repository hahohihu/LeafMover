#Include "Areas.ahk"
#Include "CraftedSet.ahk"

class Activity {
    Cooldown := 1500
    Area := Areas.Any()
    CraftedSet := CraftedLeaves.Any
    Act() {
        throw Error("TODO")
    }

    ModulateCooldown(Faster) {
        if Faster {
            this.ActiveCooldown := Max(this.Cooldown, this.GetCooldown() / 2)
        } else {
            this.ActiveCooldown := this.GetCooldown() * 2
        }
    }

    GetCooldown() {
        if this.HasProp("ActiveCooldown") {
            return this.ActiveCooldown
        } else {
            return this.Cooldown
        }
    }

    Run() {
        CraftedLeaves.LoadSet(this.CraftedSet)
        Areas.Goto(this.Area)
        this.Act()
    }
}

class Nap extends Activity {
    Act() {
        Sleep 1000
    }
}

class Stay extends Activity {
    MinTime := 3000

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

    WithMinTime(MinTime) {
        this.MinTime := MinTime
        return this
    }

    Act() {
        Center.Move()
        Sleep this.MinTime
    }
}