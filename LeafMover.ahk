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
    .WithMinTime(30000)

TradeActivity := Trades([
    Trade("Cheese", 2),
    Trade("Beer", 2),
    Trade("Borb", 5),
    Trade("Gem")
])

ClawMachine := ClawFarming([
    [GemRed, GemDarkRed, GemShadow],
    ; [HalloweenOrange, HalloweenYellow, HalloweenGreen]
])

WinActivate GameTitle

poll := TimedPoll(Stay()
            .WithArea(Areas.DarkGlade())
            .WithPetTeam(2)
        )
; poll := TimedPoll()
; poll := TimedPoll(ClawMachine)
; poll := TimedPoll(StayInTower)
; poll := TimedPoll(SpamVortex())
; Areas.SetFillerArea(Areas.DarkGlade())
; Areas.SetFillerArea(Areas.Tower())
; todo : OCR, make trades more flexible
; poll.AddNow(CursedHalloween())
poll.AddNow(TradeActivity)
poll.AddNow(Crafting())
poll.AddNow(DiceFarm())
poll.AddNow(Witch())
poll.AddNow(Centaur())
poll.AddNow(VileCreature())
; poll.AddNow(MaterialTrades([Essence.Water]))
poll.Run()