class Entry {
    __New(action, duration) {
        this.action := action
        this.duration := duration
    }

    Execute() {
        Clear
        ret := (this.action)()
        Clear
        return ret
    }
}

class TimedPoll {
    __New() {
        this.entries := []
    }

    Add(entry) {
        SetTimer AddAction, -entry.duration
        AddAction() {
            this.entries.Push(entry)
        }
    }

    AddStartup(entry) {
        entry.Execute()
        this.Add(entry)
    }

    Wait() {
        Loop {
            try {
                return this.entries.RemoveAt(1)
            } catch ValueError as e {
                Sleep 1000
            }
        }
    }
}