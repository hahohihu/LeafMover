#Include "Areas.ahk"

class Activity {
    Cooldown := 1500
    Area := Areas.Any()
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