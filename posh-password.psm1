function New-Password {
    param(
        [int]$Length = 16,
        [int]$UpperLetter = 2,
        [int]$LowerLetter = 2,
        [int]$Number = 2,
        [int]$Symbol = 2
    )
    $minlength = $UpperLetter + $LowerLetter + $Number + $Symbol
    if($Length -lt $minlength){
        Write-Error -Message "Length too short. Minimum character length is $minlength."
        return
    }
    $lowers = (97..122) | ForEach-Object {[char]$_}
    $uppers = (65..90) | ForEach-Object {[char]$_}
    $symbols = ((33..47) | ForEach-Object {[char]$_})
    $symbols += ((58..64) | ForEach-Object {[char]$_})
    $numbers = (48..57) | ForEach-Object {[char]$_}
    $all = $lowers + $uppers + $symbols + $numbers
    $pwd = @()
    if($UpperLetter -ne 0){(Get-Random -Count $UpperLetter -InputObject $uppers) | ForEach-Object {$pwd+=$_}}
    if($LowerLetter -ne 0){(Get-Random -Count $LowerLetter -InputObject $lowers) | ForEach-Object {$pwd+=$_}}
    if($Symbol -ne 0){(Get-Random -Count $Symbol -InputObject $symbols) | ForEach-Object {$pwd+=$_}}
    if($Number -ne 0){(Get-Random -Count $Number -InputObject $numbers) | ForEach-Object {$pwd+=$_}}
    if($pwd.Count -lt $Length){
        $pwd += (Get-Random -Count ($Length - $pwd.Count) -InputObject $all)
    }
    -join ($pwd | Sort-Object { Get-Random })
}