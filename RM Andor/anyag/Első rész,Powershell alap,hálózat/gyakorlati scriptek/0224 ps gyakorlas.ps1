Get-Date

Get-Process

Get-ChildItem

Get-Command


Get-LocalUser

$felhasznalo = 'Andor'

Get-LocalUser $felhasznalo | Select *

New-LocalUser

Get-LocalUser | Get-Member


Get-LocalUser
$a = Get-LocalUser $felhasznalo
$a | Get-Member
Get-LocalUser $felhasznalo | Select *


#uj felhasznalo létrehozás jelszó nélkül 
$ujnev = "Demo2"
$ujleiras = "Demo2 teszt felhasznalo"
New-LocalUser -Name $ujnev -Description $ujleiras -NoPassword



$ujnev = "Demo2"
$ujleiras = "Demo2 teszt felhasznalo"
$jelszo2 = ConvertTo-SecureString "teszt" -AsPlainText -Force
New-LocalUser -Name $ujnev -Description $ujleiras -Password $jelszo2

Get-Command -Noun LocalUser
$regi = Remove-LocalUser -Name jhk

-------------------------------------------------------------------------------------------------------------------------------------------

$csoportok | ForEach-Object { Get-LocalGroupMember -Group $_ } # csoportokban melyik user szerepel benne
Get-LocalGroupMember -Group Felhasználók

$felhasznalok = Get-LocalUser     #milyen csoportjai vannak az usereknek

foreach ($felhasznalo in $felhasznalok) {
    $felhasznalo.Name
    $felhasznalo.LastLogon
}

Write-Host $felhasznalok

Get-LocalUser |
    ForEach-Object {
        $nm = $_.name
        [pscustomobject]@{
            Name = $nm
            Groups = Get-LocalGroup |
                Where-Object { (Get-LocalGroupMember $_).name  -contains "$env:COMPUTERNAME\$nm" } |
                ForEach-Object name 
         }
    }

$users = Get-LocalUser;
foreach ($user in $users) {
    Write-Output $user" nevü felhasználó a következő csoportok tagja:" 
    $groups = Get-LocalGroup;
    foreach ($group in $groups) {
        $members = Get-LocalGroupMember -Group $group;
        foreach ($member in $members) {
            if (($member.Name.ToString() -split "\\")[1] -eq $user.Name) {
                Write-Output "-$group";
            }
        }
    }
    Write-Output " "
}