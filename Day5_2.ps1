$PolyString = Get-Content $PSScriptRoot\Inputs\Day5_Input.txt
$InitLength = $PolyString.Length
$Lengths = @()
$CharTable = @{}
 Foreach ($Num in @(65..90)){
    $Mod = $Num + 32
    $Upper = [Convert]::ToChar($Num)
    $Lower = [Convert]::ToChar($Mod)
    $CharTable.Add($Upper,$Lower)
}
ForEach ($remUpper in $CharTable.Keys){
    $remLower = $CharTable.Item($remUpper)
    $ModString = $PolyString.Replace("$remUpper",'')
    $ModString = $ModString.Replace("$remLower",'')
    Do{
        $Done = $true
        ForEach ($Upper in $CharTable.Keys){
            $Lower = $CharTable.Item($Upper)
            Write-Progress -Activity "Compacting ModString without $remUpper/$remLower" -Status "$($ModString.Length)" -PercentComplete (($ModString.Length / $InitLength)*100)
            If (($ModString -clike "*$Upper$Lower*") -or ($ModString -clike "*$Lower$Upper*")){
                $Done = $false
                $ModString = $ModString.Replace("$Upper$Lower",'')
                $ModString = $ModString.Replace("$Lower$Upper",'')
            }
        }
    }
    Until ($Done)
    $Lengths += $ModString.Length
}
Return ($Lengths | Sort)[0]