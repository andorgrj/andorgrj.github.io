Könyvtár tartalmának lekérdezése:
Method1
Get-ChildItem .\Desktop\andor.txt

$k = Get-ChildItem .\Desktop\andor.txt

$k | Get-Member

$k.Name

$k.Attributes

$k.Directory

$k.Name

$k = Get-ChildItem .\Desktop     -Recurse (az alatta lévő fájlokat is lekérdezi a recurse parancssal)

$k | Get-Member

$k.Name


Get-Command -Noun item   - fájl és könyvtárműveletek lekérdezése amit tudunk csinálni

-------------------------------------------------------------------------------------------------------------------------------------------------------
Method2 / és csv fájlba importálása
$a = Get-ChildItem -Directory -Recurse
$a | Select-Object Name, FullName | Export-Csv .\masodikcsv.csv
Get-Content .\masodikcsv.csv

$a | Get-Member
$b = Import-Csv .\masodikcsv.csv

$b | Format-List
$b.Length
$b[0].Name


-------------------------------------------------------------------------------------------------------------------------------------------------------

Új könyvtár létrehozása


Method1

New-Item -Name elso.txt

New-Item -Name elso.csv -ItemType Directory

#Remove-Item .\elso.csv

------------------------------------------------------------------------------------------------------------------------------------------------------
Method2

New-Item -Name elsocsv.csv -ItemType Directory
#Remove-Item .\elsocsv.csv
Write-Host "Név,.\Útvonal" | Out-File .\elsocsv.csv -Append
Get-Content .\elsocsv.csv


------------------------------------------------------------------------------------------------------------------------------------------------------
Új könyvtár létrehozása útvonal megadásával

New-Item -Name Dir2 -Path .\Dir1 -ItemType Director

------------------------------------------------------------------------------------------------------------------------------------------------------

Könyvtárban lévő dolgok lekérdezése majd csv export

$a = Get-ChildItem -Directory
$a
$a = Get-ChildItem -Directory -Recurse
$a
$a | Export-Csv .\masodikcsv.csv
Get-Content .\masodikcsv.csv
$a | Format-List
$a.Length

------------------------------------------------------------------------------------------------------------------------------------------------------

Könyvtár tartalmának lekérdezése majd leválogatása select objectel majd importálás és list formázás

$a = Get-ChildItem -Directory -Recurse
$a | Select-Object Name, FullName | Export-Csv .\masodikcsv.csv
Get-Content .\masodikcsv.csv

$a | Get-Member
$b = Import-Csv .\masodikcsv.csv

$b | Format-List -a könyvtár írásra, módosításra vonatkozó adatokat adja ki
$b.Length
$b[0].Name -könyvtárban lévő 0. és akárhanyadik elem nevének lekérdezése
$c | Format-List | Where-Object {$_.LastWriteTime -gt 1} - utolsó módosításokra szűrhetek


----------------------------------------------------------------------------------------------------------------------------------------------------

Get-Command -Noun Item
$t = Get-Item .\harmadik.csv

$t



Get-PSDrive
Get-PsProvider

-----------------------------------------------------------------------------------------------------------------------------------------------------



$konyvtarak = Import-Csv .\folders.csv
$konyvtarak[14].name
$konyvtarak | ForEach-Object {Write-Host $_.name}
New-Item -Path $konyvtarak[0].Name -ItemType Directory -Name neger

-------------------------------------------------------------------------


Fájl felolvasása és létrehozása

$konyvtarak = Import-Csv .\folders.csv
$konyvtarak[14].name
$konyvtarak | ForEach-Object {Write-Host $_.name}
New-Item -Path $konyvtarak[0].Name -ItemType Directory 

$csvpath = ".\folders.csv"

$csvpathletezik = Test-Path -Path $csvpath

$valasz = @('&Yes', '&No')
$dontes = $Host.UI.PromptForChoice('Konyvtarak letrehozasa','Biztos benne?', $valasz, 1)
If ($dontes -eq 0) {
    $konyvtarak | ForEach-Object {Write-Host $_.Name}
}
Else {
    Write-Host "Faszt" -BackgroundColor DarkGreen
}



$konyvtarak | ForEach-Object {New-Item -Path $_.name -ItemType directory}


#Remove-Item -Path C:\Users\admin\ifksp\andorgrj.github.io\PowerShell\RM\Front_Office


#Join-Path - több útvonalat lehet összefűzni vele






---------------------------------------------------------------------------------------------------------------------------------

$csvpath = Read-Host -Prompt "Fájl elérési útja, neve:"
$konyvtarak = Import-Csv $csvpath
$csvpathletezik = Test-Path -Path $csvpath
If (Test-Path -Path $csvpath) {

}
Else {
    Write-Host "Nem"
}




















---------------------------------------------------------------------------------------------------------------------------------
New-Item -Name elsocsv.csv -ItemType Directory
"Konyvtarmaker" | Out-file .\elsocsv.csv\.txt -Append
Get-Content .\elsocsv.csv\.txt
New-Item -Name elsocsv2.csv -ItemType File

#Könyvtárak létrehozása útvonal megadásával
New-Item -Name Dir2 -Path .\Dir1 -ItemType Directory
#Remove-Item .\Dir1\Dir3


New-Item -Name elsocsv.csv -ItemType Directory
#Remove-Item .\elsocsv.csv
Write-Host "Konyvtarmaker,.\Konyvtarmaker" | Out-File .\elsocsv.csv
Get-Content .\elsocsv.csv




Kis változtatással: (módosítások dátuma szerepel)

New-Item -Name elsocsv.csv -ItemType Directory
#Remove-Item .\elsocsv.csv
Write-Host "Konyvtarmaker,.\Konyvtarmaker" | Out-File .\elsocsv.csv
Get-Content .\elsocsv.csv


New-Item -Name elsocsv.csv -ItemType Directory
"Konyvtarmaker" | Out-file .\elsocsv.csv\.txt -Append
Get-Content .\elsocsv.csv\.txt
New-Item -Name elsocsv2.csv -ItemType File

#Könyvtárak létrehozása útvonal megadásával
New-Item -Name Dir2 -Path .\Dir1 -ItemType Directory
#Remove-Item .\Dir1\Dir3


New-Item -Name elsocsv.csv -ItemType Directory
#Remove-Item .\elsocsv.csv
Write-Host "Konyvtarmaker,.\Konyvtarmaker" | Out-File .\elsocsv.csv
Get-Content .\elsocsv.csv




