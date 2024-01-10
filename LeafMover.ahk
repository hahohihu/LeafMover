#Requires AutoHotkey v2.0

#Include "Alchemy.ahk"
#Include "MaterialTrades.ahk"
#Include "Utility.ahk"

^Esc::ExitApp
^P::Pause(-1)

CoordMode "Mouse", "Client"
; client is the default for everything
; game must be windowed

^L::ScreenScan

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

WinActivate GameTitle
