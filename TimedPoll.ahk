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
        SetTimer AddAction, -entry.duration
        AddAction() {
            this.entries.Push(entry)
        }
    }

    AddStartup(entry) {
        entry.Execute()
        this.Add(entry)
    }

    Take() {
        return this.entries.Pop()
    }
}