Localuserlétrehozása, a megadott útvonalon a csv fájlból veszi fel az adatokat majd a newlocaluser hozza létre őt a felhasználók közé, amit a számítógép-kezelésben lehet ellenőrizni



$csvutvonal = "C:\Users\admin\ifksp\andorgrj.github.io\PowerShell\RM\users.csv"

Test-Path -Path $csvutvonal #ezzel ellenőrzöm, hogy létezik az útvonal

IF (Test-Path -Path $csvutvonal) {
    $csvtartalom = Import-Csv -Path $csvutvonal
}
$csvtartalom | Format-Table #ezzel kiiratom szépre ha meg akarom nézni


#innentől hozza létre a felhasználóként a csv fájlban megadott adatok szerint
$csvtartalom[0].Name

New-LocalUser -Name $csvtartalom[0].Name -FullName $csvtartalom[0].FullName -Description $csvtartalom[0].Description


Remove-LocalUser -Name $csvtartalom[0].Name  #ezzel pedig törölni lehet a létrehozott localusert



------------------------------------------------------------------------------------------------------------------------------------------
Ugyanaz, itt jelszót magának szedi fel a csv-ből


$csvutvonal = "C:\Users\admin\ifksp\andorgrj.github.io\PowerShell\RM\users.csv"

IF (Test-Path -Path $csvutvonal) {
    $csvtartalom = Import-Csv -Path $csvutvonal
    #ForEach {$felhasznalo in $csvtartalom} {
        #Write-Host $felhasznalo.Name
    #}
}
$csvtartalom.Name
$csvtartalom.Description

$csvtartalom[0].Name

$jelszo = ConvertTo-SecureString $csvtartalom[0].Password -AsPlainText -Force
$jelszo2 = ConvertFrom-SecureString $jelszo
$jelszo3 =ConvertTo-SecureString $jelszo2

New-LocalUser -Name $csvtartalom[0].Name`
                 -FullName $csvtartalom[0].FullName`
                 -Description $csvtartalom[0].Description`
                 -Password (ConvertTo-SecureString $csvtartalom[0].Password -AsPlainText -Force)

$magdi = Get-LocalUser -Name magdolna.kiss
$magdi | Get-Member

----------------------------------------------------------------------------------------------------------------------------------

Itt minden felhasználót létrehoz ami a csv-ben benne van és jelszót is hozzáadja

$csvutvonal = "C:\Users\admin\ifksp\andorgrj.github.io\PowerShell\RM\users.csv"

IF (Test-Path -Path $csvutvonal) {
    $csvtartalom = Import-Csv -Path $csvutvonal
    ForEach ($felhasznalo in $csvtartalom) {
        #Write-Host $felhasznalo.Name
        New-LocalUser -Name $felhasznalo.Name`
                 -FullName $felhasznalo.FullName`
                 -Description $felhasznalo.Description`
                 -Password (ConvertTo-SecureString $felhasznalo.Password -AsPlainText -Force)


                 Add-LocalGroupMember -Group $felhasznalo.Group -Member $felhasznalo.Name ------->a megfelelő csoportba tudom ezzel berakni őket
    }
}


----------------- így tudom törölni őket:
IF (Test-Path -Path $csvutvonal) {
    $csvtartalom = Import-Csv -Path $csvutvonal
    ForEach ($felhasznalo in $csvtartalom) {
        #Write-Host $felhasznalo.Name
        <#
        New-LocalUser -Name $felhasznalo.Name`
                 -FullName $felhasznalo.FullName`
                 -Description $felhasznalo.Description`
                 -Password (ConvertTo-SecureString $felhasznalo.Password -AsPlainText -Force)
           #>
        Remove-LocalUser -Name $felhasznalo.Name
    }
}


-------------------------------------------------------------------------------------------------------------------------------------------------------
CSoportot fel tudunk venni csoport felhasználók közé

$a = Get-LocalGroup -Name Felhasználók
$a
Add-LocalGroupMember -Group Ujcsoport1 -Member $a.Name


Get-CimInstance -ClassName Win32_ComputerSystem -Property UserName

Get-Ciminstance Win32_OperatingSystem | Select *memory*

#8. Get-Process | Where-Object {$PSItem.Id -EQ 5100 -or $PSItem.Id -EQ 3988}
# 7. valamit még selectelni kellene itt, de nem tudom mit 
Resolve-DnsName -Server 8.8.8.8 -Name progmasters.hu -Type ALL