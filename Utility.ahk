GameTitle := "Leaf Blower Revolution"

BackgroundBrown := 0x97714a
ActiveBeige := 0xfff1d2
QuitRed := 0xdd1a1e
CheckGreen := 0x2fd117

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
        Sleep 50
    }
}

Msg(msg) {
    MsgBox msg
    WinActivate GameTitle
}
