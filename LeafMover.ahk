#Requires AutoHotkey v2.0

#Include "Alchemy.ahk"
#Include "MaterialTrades.ahk"
#Include "Trades.ahk"
#Include "Utility.ahk"
#Include "TimedPoll.ahk"
#Include "Materials.ahk"
#Include "ClawFarming.ahk"

^Esc::ExitApp
^P::Pause(-1)

CoordMode "Mouse", "Client"
; client is the default for everything
; game must be windowed

WinActivate GameTitle

poll := TimedPoll()
poll.AddStartup(Trades([
    ; Trade("Cheese", 2000),
    Trade("Mulch", 30000),
    Trade("Cheese", 0),
    Trade("Beer", 0)
]))
; todo : OCR, make trades more flexible
Essences := [Essence.Water, Essence.Leaf, Essence.Cosmic]
; poll.AddStartup(EssenceCrafting(Essences))
; poll.AddStartup(MaterialTrades(Essences))
poll.Add(MaterialFarming())
; poll.Add(ClawFarming())
poll.Run()
