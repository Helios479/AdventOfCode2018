$PolyString = Get-Content $PSScriptRoot\Inputs\Day5_Input.txt
$InitLength = $PolyString.Length
Do{
    $Done = $true
    Foreach ($Num in @(65..90)){
        $Mod = $Num + 32
        $Upper = [Convert]::ToChar($Num)
        $Lower = [Convert]::ToChar($Mod)
        Write-Progress -Activity "Compacting PolyString" -Status "$($PolyString.Length)" -PercentComplete (($PolyString.Length / $InitLength)*100)
        If (($PolyString -clike "*$Upper$Lower*") -or ($PolyString -clike "*$Lower$Upper*")){
            $Done = $false
            $Polystring = $Polystring.Replace("$Upper$Lower",'')
            $Polystring = $PolyString.Replace("$Lower$Upper",'')
        }
    }
}
Until ($Done)
Return $PolyString.Length