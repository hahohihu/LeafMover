class TimedPoll {
    __New() {
        this.activities := []
    }

    Add(activity) {
        SetTimer AddActivity, -activity.Cooldown
        AddActivity() {
            this.activities.Push(activity)
        }
    }

    AddStartup(activity) {
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
        area := Areas.Kokkaupuni
        Areas.Open(area)
        Loop {
            activity := poll.Wait()
            Clear
            if (activity.Area != Areas.Any && activity.Area != area) {
                area := activity.Area
                Areas.Open(activity.Area)
            }
            Clear
            activity.Act()
            Clear
            poll.Add(activity)
        }
    }
}