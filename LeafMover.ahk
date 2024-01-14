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

DEBUG := true ; magically used elsewhere

WinActivate GameTitle

poll := TimedPoll()
Areas.SetFillerArea(Areas.DarkGlade())
; todo : OCR, make trades more flexible
poll.AddNow(Witch())
poll.AddNow(Trades([
    Trade("Mulch", 1, 5),
    Trade("Cheese", 1, 4),
    Trade("Beer", 3, 3),
    Trade("Gem", 1)
]))
; poll.AddNow(Crafting())
; poll.AddNow(DiceRoll())
; poll.AddNow(DiceFarm())
; poll.AddNow(MaterialTrades([Essence.Water, Essence.Cosmic]))
poll.AddNvow(MaterialFarming())
; poll.AddNow(ClawFarming())
poll.Run()
