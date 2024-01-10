#Requires AutoHotkey v2.0

#Include "Alchemy.ahk"
#Include "MaterialTrades.ahk"
#Include "Trades.ahk"
#Include "Utility.ahk"
#Include "TimedPoll.ahk"
#Include "Materials.ahk"

^Esc::ExitApp
^P::Pause(-1)

CoordMode "Mouse", "Client"
; client is the default for everything
; game must be windowed

WinActivate GameTitle
Clear

poll := TimedPoll()
poll.AddStartup(Entry(TakeAllTrades, 120000))
poll.Add(Entry(FarmMaterials, 5000))
Loop {
    action := poll.Wait()
    action.Execute()
    poll.Add(action)
    Clear
}