class TimedPoll {
    __New(BackgroundActivity := Nap()) {
        this.activities := []
        this.backgroundActivity := BackgroundActivity
    }

    AddNow(activity) {
        this.activities.Push(activity)
    }

    AddLater(activity) {
        SetTimer AddLater, -activity.GetCooldown()
        AddLater() {
            this.AddNow(activity)
        }
    }

    Wait() {
        Loop {
            try {
                return this.activities.RemoveAt(1)
            } catch ValueError as e {
                this.backgroundActivity.Run()
            }
        }
    }

    StringifyQueue() {
        ret := ""
        for activity in this.activities {
            ret := ret " " Type(activity)
        }
        return ret
    }

    Run() {
        Loop {
            activity := poll.Wait()
            start := TimeNow()
            WinActivate GameTitle
            activity.Run()
            Log(start " --- " "[" Type(activity) "] " this.StringifyQueue())
            WinActivate GameTitle
            Clear
            Center.Move()
            this.AddLater(activity)
        }
    }
}