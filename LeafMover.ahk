#Requires AutoHotkey v2.0

#Include "Alchemy.ahk"
#Include "MaterialTrades.ahk"
#Include "Trades.ahk"
#Include "Utility.ahk"
#Include "TimedPoll.ahk"
#Include "Materials.ahk"
#Include "ClawFarming.ahk"
#Include "Crafting.ahk"
#Include "Dice.ahk"

^Esc::ExitApp
^P::Pause(-1)

CoordMode "Mouse", "Client"
; client is the default for everything
; game must be windowed

WinActivate GameTitle

poll := TimedPoll()
Areas.SetFillerArea(Areas.DarkGlade())
; todo : OCR, make trades more flexible
poll.Add(Trades([
    Trade("Mulch", 4, 12),
    Trade("Cheese", 4, 10),
    Trade("Beer", 4, 8),
    Trade("Gem", 1)
]))
poll.Add(Crafting())
; poll.Add(DiceRoll())
; poll.Add(DiceFarm())
; poll.Add(MaterialTrades([Essence.Water, Essence.Leaf, Essence.Cosmic]))
; poll.Add(MaterialFarming())
; poll.Add(ClawFarming())
poll.Run()
