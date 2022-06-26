$a = Get-LocalUser
$a
$a | Get-Member
$a | Select-Object -Property Name, Enabled

Get-LocalGroup
Get-LocalGroupMember -Group Felhasználók

Get-Command -Noun Local*





$b = Get-LocalUser -Name admin
$b | Get-Member 
$b | Select-Object -Property LastLogon

$b.Description
$b.FullName
$b.LastLogon

Get-Acl
Get-SmbShare