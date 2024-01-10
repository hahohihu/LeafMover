#Requires AutoHotkey v2.0

#Include "Alchemy.ahk"
#Include "MaterialTrades.ahk"
#Include "Trades.ahk"
#Include "Utility.ahk"
#Include "TimedPoll.ahk"

^Esc::ExitApp
^P::Pause(-1)

CoordMode "Mouse", "Client"
; client is the default for everything
; game must be windowed

WinActivate GameTitle
Clear

poll := TimedPoll()
poll.AddStartup(Entry(TakeAllTrades, 120000))
LoadPetTeam(2)
Loop {
    try {
        action := poll.Take()
        action.Execute()
        poll.Add(action)
        LoadPetTeam(2)
    } catch Error as e {
        Clear
        ScreenScan
        Sleep 3000
    }
}