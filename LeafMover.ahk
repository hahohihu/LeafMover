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
; todo : OCR, make trades more flexible
poll.Add(Trades([
    Trade("Mulch", 4, 10),
    Trade("Cheese", 4, 5),
    Trade("Beer", 4),
    Trade("Gem", 1)
]))
; poll.Add(DiceRoll())
; poll.Add(DiceFarm())
; poll.Add(MaterialTrades([Essence.Water, Essence.Leaf, Essence.Cosmic]))
; poll.Add(MaterialFarming())
poll.Add(ClawFarming())
; poll.Add(Crafting())
poll.Run()
