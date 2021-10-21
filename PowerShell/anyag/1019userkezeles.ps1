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
    ForEach {$felhasznalo in $csvtartalom} {
        Write-Host $felhasznalo.Name
    }
}
$csvtartalom.Name
$csvtartalom.Description

csvtartalom[0].Name

$jelszo = ConvertTo-SecureString $csvtartalom[0].Password -AsPlainText -Force
$jelszo2 = ConvertFrom-SecureString $jelszo
$jelszo3 =ConvertTo-SecureString $jelszo2

New-LocalUser -Name $csvtartalom[0].Name`
                 -FullName $csvtartalom[0].FullName`
                 -Description $csvtartalom[0].Description`
                 -Password (ConvertTo-SecureString $csvtartalom[0].Password -AsPlainText -Force)

