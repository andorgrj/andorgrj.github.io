Get-NetIpAddress -AddressFamily IPv6

Route PRINT

$a = 1..20  -----> számok kiiratása
$b = @('zero','One', 'Two')  ------> hash
$b | ForEach-Object {$PSItem}

$c = [char[]]([char]'A'..[char]'Z') ------> betűk, karakterek kiiratása

$number = 5
1..10 | ForEach-Object {Write-Host $_ " * $number = " ($_ * $number)}

$tabla = 1..20
$aholvan = 1
$bholvan = 7
$cholvan = 13
$tabla.Length
$tabla[13]
$tabla[13] | Get-Member

$data[2] += hozzáadás
tömbkezelés 

switch

switch ($b)
{
       "One" {"It is one"}
       "Two" {"It is two"}
       "Three" {"It is three"}
       default {"It is four"}
}


(Get-Host).UI.RawUI.BackgroundColor = "Red"  ---> parancsok hátterének átállítása