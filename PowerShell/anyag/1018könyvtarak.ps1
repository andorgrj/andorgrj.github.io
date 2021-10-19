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


Method2 / és csv fájlba importálása
$a = Get-ChildItem -Directory -Recurse
$a | Select-Object Name, FullName | Export-Csv .\masodikcsv.csv
Get-Content .\masodikcsv.csv

$a | Get-Member
$b = Import-Csv .\masodikcsv.csv

$b | Format-List
$b.Length
$b[0].Name




Új könyvtár létrehozása


Method1

New-Item -Name elso.txt

New-Item -Name elso.csv -ItemType Directory

#Remove-Item .\elso.csv


Method2

New-Item -Name elsocsv.csv -ItemType Directory
#Remove-Item .\elsocsv.csv
Write-Host "Név,.\Útvonal" | Out-File .\elsocsv.csv -Append
Get-Content .\elsocsv.csv



Új könyvtár létrehozása útvonal megadásával

New-Item -Name Dir2 -Path .\Dir1 -ItemType Director





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


Könyvtár tartalmának lekérdezése

$a = Get-ChildItem -Directory -Recurse
$a | Select-Object Name, FullName | Export-Csv .\masodikcsv.csv
Get-Content .\masodikcsv.csv

$a | Get-Member
$b = Import-Csv .\masodikcsv.csv

$b | Format-List
$b.Length
$b[0].Name


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

$a = Get-ChildItem -Directory -Recurse

$a | Select-Object Name, FullName | Export-Csv .\masodikcsv.csv
$a | Export-Csv .\harmadik.csv
Get-Content .\masodikcsv.csv

$a | Get-Member
$b = Import-Csv .\harmadikcsv.csv
$b.Length
$b[0].Name

Get-Command -Noun Item
$t = Get-Item .\harmadik.csv

$t



Get-PSDrive
