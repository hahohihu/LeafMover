#Include "Utility.ahk"

class Essence {
    class Cosmic {
        static location := Point(1255, 230)
        static merchantLocation := Point(430, 660)
    }
    class Earth {
        static location := Point(1255, 330)
        static merchantLocation := Point(703, 795)
    }
    class Leaf {
        static location := Point(1255, 430)
        static merchantLocation := Point(1000, 680)
    }
    class Water {
        static location := Point(1255, 530)
        static merchantLocation := Point(1273, 686)
    }
}

MakeEssences(choices) {
    Inner() {
        Clicc 800, 905 ; alchemy 
        Clicc 546, 878 ; Essences
        for choice in choices {
            choice.location.Click()
        }
    }
    return Inner
}
