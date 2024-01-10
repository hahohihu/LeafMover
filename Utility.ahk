BackgroundBrown := 0x97714a
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
}

class Area {
    __New(TopLeft, BottomRight)
    {
        this.TopLeft := TopLeft
        this.BottomRight := BottomRight
    }

    FromRaw(x1, y1, x2, y2) {
        return Area(Point(x1, y1), Point(x2, y2))
    }

    ToArea() {
        return this
    }
}

ImageTest(area, image) {
    area := area.ToArea()
    return ImageSearch(&Px, &Py, area.TopLeft.x, area.TopLeft.y, area.BottomRight.x, area.BottomRight.y, image)
}

Clicc(point, y := "NaN") {
    if y = "NaN" {
        x := point.x
        y := point.y
    } else {
        x := point
    }
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