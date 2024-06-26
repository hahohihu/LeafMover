#Include "Utility.ahk"

class CraftedLeaves {
    static _LoadSet(n) {
        Clicc 1114, 900 ; crafting
        Clicc 1130, 875 ; Sets
        Clicc 415, 420 + (n - 1) * 102
    }

    static Any := 0
    static Current := CraftedLeaves.Any
    static LoadSet(n) {
        if n != CraftedLeaves.Any and n != CraftedLeaves.Current {
            Clear
            CraftedLeaves._LoadSet(n)
            CraftedLeaves.Current := n
            Clear
        }
    }

}
