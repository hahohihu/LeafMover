#Requires AutoHotkey v2.0

#Include "Materials.ahk"

^Esc::ExitApp
^P::Pause(-1)

GameTitle := "Leaf Blower Revolution"
CoordMode "Mouse", "Client"
; client is the default for everything
; game must be windowed

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

^L::ScreenScan
^#L:: 
{
    Loop {
        MakeEssences
        Loop 9 {
            ScreenScan
        }
    }
}

^K::
{
    Loop {
        ControlSend "v",, GameTitle
        Sleep 100
        ControlSend "{Space}",, GameTitle
        Sleep 100
        ControlSend "v",, GameTitle
        Sleep 40000
    }
}
^C::
{
    Loop {
        MakeEssences
        Clear
        ; Clicc 430, 660 ; wayland
        Clicc 1000, 680 ; torvalds
        Loop 70 {
            Clicc 1300, 230 ; trade
            Sleep 250
            if NotEnoughMaterials
                Clicc 1525, 230 ; cancel
            Sleep 250
        }
    }
}

^D::
{

}
