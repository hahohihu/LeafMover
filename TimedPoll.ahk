class Entry {
    __New(action, duration) {
        this.action := action
        this.duration := duration
    }

    Execute() {
        return (this.action)()
    }
}

class TimedPoll {
    __New() {
        this.entries := []
    }

    Add(entry) {
        i := this.entries.Length
        SetTimer AddAction, -entry.duration
        AddAction() {
            this.entries.Push(entry)
        }
    }

    Take() {
        return this.entries.Pop()
    }
}