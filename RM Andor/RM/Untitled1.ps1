Get-ChildItem .\Desktop\andor.txt
$a = Get-ChildItem .\Desktop\andor.txt
$a | Get-Member
$a.Name

$b = Get-ChildItem .\ifksp -Recurse
$b.Name

Get-Command -Noun Item

New-Item -Name elso.csv -ItemType Directory
Remove-Item elso.csv

New-Item -Name elsocsv.csv -ItemType file
Write-Host "Konyvtarmaker, .\elsocsv.csv" | Out-File elsocsv.csv 
Remove-Item elsocsv.csv

Get-Content .\elsocsv.csv

New-Item -Name Dir2 -Path .\Dir1 -ItemType Director
Remove-Item Dir1

$a = Get-ChildItem -Directory -Recurse

$a | Select-Object Name, FullName | Export-Csv .\masodikcsv.csv

Get-Content .\masodikcsv.csv

$b = Import-Csv .\masodikcsv.csv

$b | Format-List

$b.Length

Remove-Item elsocsv.txt