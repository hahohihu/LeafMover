#Include "Lib/AHKv2-Gdip/Gdip_All.ahk"

GameTitle := "Leaf Blower Revolution"

BackgroundBrown := 0x97714a
ActiveBeige := 0xfff1d2
QuitRed := 0xdd1a1e
CheckGreen := 0x2fd117
White := 0xffffff
GemRed := 0xff0044
GemDarkRed := 0x5e0c22
GemShadow := 0xeb2e60
AttackTeal := 0x2ce8f5
HpBarRed := 0xff0000

class Point {
    __New(x, y)
    {
        this.x := x
        this.y := y
    }

    ToArea() {
        return Area(this, Point(this.x + 1, this.y + 1))
    }

    PixelTest(color) {
        return this.ToArea().PixelTest(color)
    }

    Click() {
        Clicc(this.x, this.y)
    }

    Move() {
        MouseMove this.x, this.y
        Sleep 50
    }

    ClientToScreen() {
        hwnd := WinExist(GameTitle)
        buf := Buffer(8)
        NumPut("UInt", this.x, buf)
        NumPut("UInt", this.y, buf, 4)
        DllCall("ClientToScreen", "Ptr", hwnd, "Ptr", buf) ; https://msdn.microsoft.com/en-us/library/windows/desktop/dd183434(v=vs.85).aspx
        return Point(NumGet(buf, "Int"), NumGet(buf, 4, "Int"))
    }
}

class Area {
    __New(TopLeft, BottomRight)
    {
        this.TopLeft := TopLeft
        this.BottomRight := BottomRight
    }

    static FromRaw(x1, y1, x2, y2) {
        return Area(Point(x1, y1), Point(x2, y2))
    }
    
    ImageSearch(&x, &y, image) {
        return ImageSearch(&x, &y, this.TopLeft.x, this.TopLeft.y, this.BottomRight.x, this.BottomRight.y, image)
    }

    ImageTest(image) {
        return this.ImageSearch(&x, &y, image)
    }

    PixelSearch(&x, &y, pixel, variation := 0) {
        return PixelSearch(&x, &y, this.TopLeft.x, this.TopLeft.y, this.BottomRight.x, this.BottomRight.y, pixel, variation)
    }

    PixelTest(pixel, variation := 0) {
        return this.PixelSearch(&x, &y, pixel, variation)
    }

    SaveImage(OutputFile) {
        pToken := Gdip_Startup()
        w := this.BottomRight.x - this.TopLeft.x
        h := this.BottomRight.y - this.TopLeft.y
        screenPoint := this.TopLeft.ClientToScreen()
        snap := Gdip_BitmapFromScreen(screenPoint.x "|" screenPoint.y "|" w "|" h)
        if snap = -1 {
            throw ValueError("Invalid GDIP x, y, w, or h")
        }
        res := Gdip_SaveBitmapToFile(snap, OutputFile)
        if res != 0 {
            throw Error("Saving bitmap failed with error: " res)
        }
        Gdip_DisposeImage(snap)
        Gdip_Shutdown(pToken) ; todo - do this elsewhere
    }

    Scan(Inc := 200, Delay := 200) {
        x := this.TopLeft.x
        While x < this.BottomRight.x {
            MouseMove x, this.TopLeft.y, 5
            Sleep Delay
            MouseMove x, this.BottomRight.y, 5
            Sleep Delay
            x += Inc
        }
    }
}

Clicc(x, y) {
    Click x, y, "Down"
    Sleep 50
    Click x, y, "Up"
    Sleep 50
}

Clear() {
    Clicc 0, 0
}

ScreenScan() {
    x := 0
    While x < 1920 {
        MouseMove x, 0, 5
        Sleep 200
        MouseMove x, 1000, 5
        Sleep 200
        x += 200
    }
}

ScrollUp(n) {
    Loop n {
        Send "{WheelUp}"
        Sleep 5
    }
}

Msg(msg) {
    MsgBox msg
    WinActivate GameTitle
}

SetBoolTimer(&Bool, Period) {
    Bool := false
    SetTimer WakeUp, -Period
    WakeUp() {
        Bool := true
    }
}

Center := Point(900, 500)

MakeCleanDir(DirName) {
    DirDelete(DirName, true)
    DirCreate(DirName)
}

class GUID {
    static _Current := 0

    static Get() {
        return GUID._Current++
    }
}

DEBUG := false

Log(text) {
    FileAppend(A_MM "/" A_DD " @ " A_Hour ":" A_Min ":" A_Sec " --- " text "`n", "Debug/log.txt")
}

BossPresent() {
    BossHPBar := Area.FromRaw(703, 200, 704, 257)
    return BossHPBar.PixelTest(HpBarRed)
}

WaitForBossDeath() {
    SetBoolTimer &Timeout, 3000
    while not BossPresent() {
        if Timeout {
            return
        }
        Sleep 200
    }
    while BossPresent() {
        Center.Click()
        Sleep 500
    }
    Sleep 1000
    return not Center.PixelTest(BackgroundBrown)
}