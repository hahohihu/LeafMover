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

poll := TimedPoll()
poll.AddStartup(Entry(TakeAllTrades, 120000))
poll.AddStartup(Entry(MakeEssences, 30000))
poll.Add(Entry(FarmMaterials, 10000))
Loop {
    action := poll.Wait()
    action.Execute()
    poll.Add(action)
}