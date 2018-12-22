$Input = Get-Content $PSScriptRoot\Inputs\Day3_Input.txt
#Build Object for each Entry
$Plans = New-Object System.Collections.ArrayList
ForEach ($Entry in $Input){
    $Regex = [regex]::Match($Entry,'#([0-9]*).{3}([0-9]*),([0-9]*):\s([0-9]*)x([0-9]*)')
    $PlanObject = [PSCustomObject]@{
        'Id' = [Int32]$Regex.Captures.Groups.Value[1]
        'Left' = [Int32]$Regex.Captures.Groups.Value[2]
        'Top' = [Int32]$Regex.Captures.Groups.Value[3]
        'Width' = [Int32]$Regex.Captures.Groups.Value[4]
        'Height' = [Int32]$Regex.Captures.Groups.Value[5]
    }
    [void]$Plans.Add($PlanObject)
}
#Determine overlap
# Credit to /u/Vortex100 for the idea of a multidimensional array object
# https://github.com/VortexUK/AdventOfCode/blob/master/2018/Day3/solution.ps1
$Area = New-Object -TypeName 'object[,]' -ArgumentList 1100,1100
ForEach ($Claim in $Plans){
    $XEnd = $Claim.Left + $Claim.Width
    $YEnd = $Claim.Top + $Claim.Height
    For ($x = $Claim.Left ; $x -lt $XEnd ; $x ++){
        For ($y = $Claim.Top ; $y -lt $YEnd ; $y ++){
            $Area[$x,$y] += 1
        }
    }
}
$ClaimedInches = ($Area | Where-Object -FilterScript {$_ -gt 1} | Measure-Object).Count
Return $ClaimedInches