﻿#Requires AutoHotkey v2.0

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

^Esc::ExitApp
^P::Pause(-1)

CoordMode "Mouse", "Client"
; client is the default for everything
; game must be windowed

DEBUG := true ; magically used elsewhere

StayInTower := Stay()
                .WithArea(Areas.Tower())
                .WithCraftedSet(2)
                .WithMinTime(55000)

TradeActivity := Trades([
                    Trade("Mulch", 1),
                    Trade("Cheese", 1),
                    Trade("Beer", 3),
                    Trade("Gem", 1)
                ])

WinActivate GameTitle

poll := TimedPoll()
; Areas.SetFillerArea(Areas.DarkGlade())
; todo : OCR, make trades more flexible
; poll.AddNow(CursedHalloween())
poll.AddNow(DiceFarm())
poll.AddNow(TradeActivity)
poll.AddNow(Witch())
poll.AddNow(ClawFarming())
; poll.AddNow(Crafting())
; poll.AddNow(DiceRoll())
; poll.AddNow(MaterialTrades([Essence.Water, Essence.Cosmic]))
; poll.AddNow(StayInTower)
poll.Run()
