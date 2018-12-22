$Input = Get-Content "$PSScriptRoot\Inputs\Day1_Input.txt"
$Freq = 0
ForEach ($Entry in $Input){
    Write-Progress -Activity "Adding Frequency" -Status "$Freq$Entry"
    $Freq += $Entry #Updates frequency with new input
}
Return $Freq