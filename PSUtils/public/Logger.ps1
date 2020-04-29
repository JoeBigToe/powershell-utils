class Logger {

    [TimeSpan]  $elapsedtime
    [DateTime]  $timestamp
    [DateTime]  $startingtime
    [string]    $callerfunction

    Logger( [string] $filepath ){
        $this.filepath = $filepath
        $this.startingtime = get-date
    }

    Logger() {
        $this.startingtime = get-date
    }

    [void] log( [string]$message, [string]$level) {

        write-host $($this._constructLogMessage($message, $level, $null))

    }
    [void] log( [string]$message, [string]$level, $err) {

        write-host $($this._constructLogMessage($message, $level, $err))

    }

    [string] getLogMessage( [string]$message, [string]$level) {

        return $($this._constructLogMessage($message, $level, $null))

    }
    [string] getLogMessage( [string]$message, [string]$level, $err) {

        return $($this._constructLogMessage($message, $level, $err))

    }

    [string] hidden _constructLogMessage([string]$message, [string]$level, $err) {

        switch -regex ($level) {
            "^INFO$|^WARNING$" {
                $timeslot = $( (get-date -DisplayHint time) - $this.startingtime )
                $timeslotstring = "{0:d2}:{1:d2}:{2:d2}.{3:d3}" -f $timeslot.Hours, $timeslot.Minutes, $timeslot.Seconds, $timeslot.Milliseconds
                $functionslot = $(Get-PSCallStack)[2].Command

                $message = $("[$timeslotstring][$level][$functionslot] $message")
             }

            "^ERROR$" {
                $timeslot = $( (get-date -DisplayHint time) - $this.startingtime )
                $timeslotstring = "{0:d2}:{1:d2}:{2:d2}.{3:d3}" -f $timeslot.Hours, $timeslot.Minutes, $timeslot.Seconds, $timeslot.Milliseconds
                $functionslot = $(Get-PSCallStack)[2].Command


                $message = $("[$timeslotstring][$level][$functionslot] $message") + "`r`n"
                $message += $("Target object: [$($err.targetobject)]") + "`r`n"
                $message += $("Error origin: $($err.invocationinfo.positionmessage)") + "`r`n"
                $message += $("Error message: $($err.exception.message)")

             }

            Default {
            }
        }

        return $message

    }

}
