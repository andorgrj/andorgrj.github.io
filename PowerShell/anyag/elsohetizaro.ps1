Write-Output "Hello World"

$name = Read-Host -Prompt "Please enter your name"
Write-Output "Congratulations $name! you are the best but first give me your pass to show you more infos"

$jelszo = Read-Host -Prompt "Jelszó: " -AsSecureString

$date = Read-Host "What day is today?"
Write-Output "Today's date is:"
Get-Date


Read-Host -Prompt "Let me check your pc"
$info = Get-ComputerInfo
write-Host "OS tipusa:" ($info).OsName -ForegroundColor Black -BackgroundColor Yellow


$Host
$a = 10
$b = 10
$c = $a + $b
Write-Host $c
   
$result1 = $env:USERNAME
$result2 = $env:COMPUTERNAME

(Get-Computerinfo).CsModel
(Get-Computerinfo).CsManufacturer


(Get-date).AddDays(90)

Get-Date
$a = Get-ComputerInfo
$a.OsName

$filePath = "$env:USERPROFILE\Desktop\bbbbb.txt"


$a.OsName | Out-File -FilePath $filePath
Get-Date | Out-File -FilePath $filePath -Append
$name | Out-File -FilePath $filePath -Append
$info | Out-File -FilePath $filePath -Append
$result1 | Out-File -FilePath $filePath -Append
$result2 | Out-File -FilePath $filePath -Append