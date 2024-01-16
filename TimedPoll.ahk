class TimedPoll {
    __New() {
        this.activities := []
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
                Sleep 1000
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
            Log("[" Type(activity) "] " this.StringifyQueue())
            WinActivate GameTitle
            CraftedLeaves.LoadSet(activity.CraftedSet)
            Areas.Goto(activity.Area)
            activity.Act()
            WinActivate GameTitle
            Clear
            Center.Move()
            this.AddLater(activity)
        }
    }
}