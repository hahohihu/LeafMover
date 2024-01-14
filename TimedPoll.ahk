class TimedPoll {
    __New() {
        this.activities := []
    }

    Add(activity) {
        this.activities.Push(activity)
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

    Run() {
        Loop {
            activity := poll.Wait()
            Areas.Goto(activity.Area)
            activity.Act()
            Clear
            SetTimer AddLater, -activity.Cooldown
            AddLater() {
                this.Add(activity)
            }
        }
    }
}