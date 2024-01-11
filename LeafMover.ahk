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
poll.AddStartup(Trades())
poll.AddStartup(EssenceCrafting([Essence.Water, Essence.Leaf, Essence.Cosmic]))
poll.Add(MaterialTrades([Essence.Leaf, Essence.Water, Essence.Cosmic, Essence.Earth]))
poll.Add(MaterialFarming())
poll.Run()
