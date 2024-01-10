#Requires AutoHotkey v2.0

#Include "Materials.ahk"
#Include "Utility.ahk"

^Esc::ExitApp
^P::Pause(-1)

GameTitle := "Leaf Blower Revolution"
CoordMode "Mouse", "Client"
; client is the default for everything
; game must be windowed

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

^#P::
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
^#C::
{
    Loop {
        MakeEssences
        MakeTrades
    }
}

^T::
{
    if ConsumesGoodMaterial()
        MsgBox "Yes"
    else
        MsgBox "No"
}
