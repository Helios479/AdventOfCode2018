$Input = Get-Content $PSScriptRoot\Inputs\Day2_Input.txt
$2Match = 0
$3Match = 0
ForEach ($Entry in $Input) {
    $2Found = $false
    $3Found = $false
    $Entry.ToCharArray() | Group-Object | ForEach-Object {
        If (($_.Count -eq '2') -and -not $2Found){$2Match ++; $2Found = $true}
        If (($_.Count -eq '3') -and -not $3Found){$3Match ++; $3Found = $true}
    }
    
}
$Checksum = $2Match * $3Match
Return $Checksum