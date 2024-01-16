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
#Include "Events.ahk"

^Esc:: ExitApp
^P:: 
{
    WinActivate GameTitle
    Pause(-1)
}

CoordMode "Mouse", "Client"
; client is the default for everything
; game must be windowed

StayInTower := Stay()
    .WithArea(Areas.Tower())
    .WithCraftedSet(2)
    .WithMinTime(55000)

TradeActivity := Trades([
    Trade("Mulch", 5),
    Trade("Cheese", 3),
    Trade("Beer", 3),
    Trade("Gem")
])

ClawMachine := ClawFarming([
    [GemRed, GemDarkRed, GemShadow],
    ; [HalloweenOrange, HalloweenYellow, HalloweenGreen]
])

WinActivate GameTitle

poll := TimedPoll(Stay().WithArea(Areas.DarkGlade()))
Areas.SetFillerArea(Areas.DarkGlade())
; todo : OCR, make trades more flexible
; poll.AddNow(CursedHalloween())
poll.AddNow(DiceFarm())
poll.AddNow(TradeActivity)
poll.AddNow(Witch())
poll.AddNow(MaterialTrades([Essence.Water]))
; poll.AddNow(ClawMachine)
; poll.AddNow(Crafting())
; poll.AddNow(DiceRoll())
; poll.AddNow(StayInTower)
poll.Run()