#Include "Utility.ahk"

ConsumesGoodMaterial() {
    Loop Files, "Matches\*"
    {
        if ImageSearch(&Px, &Py, 800, 200, 910, 300, A_LoopFileFullPath)
            return true
    }
    return false
}

NotEnoughMaterials() {
    return PixelSearch(&Px, &Py, 875, 215, 900, 275, 0x830808)
}

MakeEssences() {
    Clicc 800, 905 ; alchemy 
    Clicc 546, 878 ; Essences
    Clicc 1255, 230 ; Cosmic
    Clicc 1255, 435 ; Leaf
}

BadTrade() {
    return ConsumesGoodMaterial() or NotEnoughMaterials()
}

ChangeAvailable() {
    return not PixelSearch(&Px, &Py, 1580, 230, 1581, 231, BackgroundBrown)
}

TradePending() {
    return PixelSearch(&Px, &Py, 1250, 220, 1280, 240, CheckGreen)
        or PixelSearch(&Px, &Py, 1380, 230, 1381, 231, BackgroundBrown)
}

MakeTrade() {
    
}