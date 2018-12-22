$Input = Get-Content "$PSScriptRoot\Inputs\Day1_Input.txt"
$Freq = 0
$History = New-Object System.Collections.ArrayList
While ($true){
    ForEach ($Entry in $Input){
        Write-Progress -Activity "Testing Frequency $($History.Count)" -Status "$Freq$Entry"
        [void]$History.Add($Freq) #Add frequency to collection of all frequencies
        $Freq += $Entry
        If ($Freq -in $History){
            Return $Freq #Return first correct answer
        }
    }
}