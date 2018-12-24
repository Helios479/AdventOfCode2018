$Input = Get-Content $PSScriptRoot\Inputs\Day4_Input.txt
#Organize Entries
$Events = New-Object System.Collections.ArrayList
ForEach ($Entry in $Input){
    $Regex = [regex]::Match($Entry,'\[(.*)\]\s(.*)')
    $Message = $Regex.Captures.Groups.Value[2]
    If ($Message -like 'Guard*'){
        $MessageRegex = [regex]::Match($Message,'#([0-9]*)\s(.*)')
        $Guard = $MessageRegex.Captures.Groups.Value[1]
        $Message = $MessageRegex.Captures.Groups.Value[2]
    }
    Else {
        $Guard = $null
        $Message = $Message
    }
    $EntryObject = [PSCustomObject]@{
        'Date' = [DateTime]$Regex.Captures.Groups.Value[1]
        'Guard' = $Guard
        'Action' = $Message
    }
    [void]$Events.Add($EntryObject)
}
#Sort and assign guards
$Events = $Events | Sort Date
ForEach ($Event in $Events){
    If ($Event.Guard) {
        $Guard = $Event.Guard
    }
    Else {
        $Event.Guard = $Guard
    }
}
#Find sleepiest guard
$OptimumTime = 0
$MinuteFrequency = 0
ForEach ($Guard in ($Events.Guard | Select -Unique)){
    $MinutesAsleep = @()
    #Get minutes asleep
    $Shifts = $Events | Where-Object Guard -EQ $Guard
    $ShiftIndex = 0..($Shifts.Count - 1)
    ForEach ($Index in $ShiftIndex){
        If ($Shifts[$Index].Action -eq 'falls asleep'){
            $Start = $Shifts[$Index]
            $End = $Shifts[$Index + 1]
            For ($i = $Start.Date.Minute ; $i -lt $End.Date.Minute ; $i ++){
                $MinutesAsleep += $i
            }
        }
    }
    #Get sleepiest minute
    If ($MinutesAsleep){
        $SleepiestMinute = ($MinutesAsleep | Group-Object | Sort Count -Descending)[0]
        If ($SleepiestMinute.Count -gt $MinuteFrequency){
            $MinuteFrequency = $SleepiestMinute.Count
            $OptimumTime = [int]$Guard * [int]$SleepiestMinute.Name
        }
    }
}
Return $OptimumTime