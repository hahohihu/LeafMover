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
    Clear
    Clicc 800, 905 ; alchemy 
    Clicc 546, 878 ; Essences
    Clicc 1255, 230 ; Cosmic
    Clicc 1255, 435 ; Leaf
}
