$Input = Get-Content $PSScriptRoot\Inputs\Day2_Input.txt
$ReturnString = ''
ForEach ($Entry in $Input){
    ForEach ($OtherEntry in ($Input | Where-Object {$_ -ne $Entry})){
        $EntryArray = $Entry.ToCharArray()
        $CompareArray = $OtherEntry.ToCharArray()
        $Compare = Compare-Object $EntryArray -DifferenceObject $CompareArray -SyncWindow 0
        If ($Compare.Count -eq 2){
            $Same = Compare-Object $EntryArray -DifferenceObject $CompareArray -SyncWindow 0 -ExcludeDifferent -IncludeEqual
            $Same | %{$ReturnString += $_.InputObject}
            Return $ReturnString
        }
    }
}