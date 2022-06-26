Fájlba írás

Get-Date | Out-File -FilePath $filePath
$filePath = "$env:USERPROFILE\Desktop\bbbbb.txt"





Több

Get-Date
$a = Get-ComputerInfo
$a.OsName

$filePath = "$env:USERPROFILE\Desktop\bbbbb.txt"


$filePath2 = "$env:USERPROFILE\Desktop\hhhhhh.txt"

$a.OsName | Out-File -FilePath $filePath2
Get-Date | Out-File -FilePath $filePath2 -Append -Encoding utf8


"ÉÉÉ ÍÍÍ ŐŐŐ" | Out-File -filePath $filePath2 -Append -Encoding utf8

------------------------------------------------------------------------------------------------------------------------------------

Get-PSDrive | Out-File C:\Users\admin\Desktop\cars.txt

Start-Process notepad C:\Users\admin\Desktop\cars.txt

Stop-Process -Name Notepad cars.txt

Get-Content C:\Users\admin\Desktop\cars.txt

$a = Get-Content C:\Users\admin\Desktop\cars.txt

$a.Count

Get-PSDrive | Export-Csv C:\Users\admin\Desktop\cars.csv   -----> fájlba kiírja az adatokat

$serv = Import-Csv c:\Users\admin\Desktop\cars.csv -------> fájlból beolvassa az import az értékeket
$serv.Count