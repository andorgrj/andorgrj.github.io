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


$a = 10
$b = 10
$c = $a + $b
Write-Host $c
   
(Get-Computerinfo).CsModel
(Get-Computerinfo).CsUsername
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


Get-CimInstance -Class Win32_LogicalDisk

Get-CimInstance -Class Win32_LogicalDisk | Select-Object Size,Freespace | Out-File -FilePath $filePath
$filePath = "$env:USERPROFILE\Desktop\size.txt"
















Write-Output "Hello World"

$name = Read-Host -Prompt "Please enter your name"
Write-Output "Congratulations $name! you are the best but first give me your pass to show you more infos"

$jelszo = Read-Host -Prompt "Jelszó: " -AsSecureString

$date = Read-Host "What day is today?"
Write-Output "Today's date is:"
Get-Date


Read-Host -Prompt "Let me check your pc"
$info = Get-ComputerInfo
Write-Host "OS tipusa:" ($info).OsName -ForegroundColor Black -BackgroundColor Yellow
$info2 = Get-Computerinfo
Write-Host "Username:" ($info2).CsUserName -ForegroundColor Black -BackgroundColor Red
$info3 = Get-ComputerInfo
Write-Host "Manufacturer:" ($info3).CsManufacturer -ForegroundColor Black -BackgroundColor DarkGreen

Get-CimInstance -Class Win32_LogicalDisk | Select-Object Size,Freespace

Get-Service | Where-Object -Property Status -Contains 'Running' | Format-Table -Property Status,DisplayName


($info).OsName| Out-File -FilePath $filePath
$filePath = "$env:USERPROFILE\Desktop\andor.txt"
($info2).CsUserName |  Out-File -FilePath $filePath -Append
($info3).CsManufacturer | Out-File -FilePath $filePath -Append


Ez jó:


Write-Output "Hello World"

$name = Read-Host -Prompt "Please enter your name"
Write-Output "okay $name! first give me your pass to show you more infos!"

$jelszo = Read-Host -Prompt "Jelszó: " -AsSecureString

$date = Read-Host "What day is today?"
Write-Output "Today's date is:"
Get-Date


Read-Host -Prompt "Let me check your pc"
$info = Get-ComputerInfo
Write-Host "OS tipusa:" ($info).OsName -ForegroundColor Black -BackgroundColor Yellow
$info2 = Get-Computerinfo
Write-Host "Username:" ($info2).CsUserName -ForegroundColor Black -BackgroundColor Red
$info3 = Get-ComputerInfo
Write-Host "Manufacturer:" ($info3).CsManufacturer -ForegroundColor Black -BackgroundColor DarkGreen



($info).OsName| Out-File -FilePath $filePath
$filePath = "$env:USERPROFILE\Desktop\andor.txt"
($info2).CsUserName |  Out-File -FilePath $filePath -Append
($info3).CsManufacturer | Out-File -FilePath $filePath -Append


Get-CimInstance -Class Win32_LogicalDisk | Select-Object Size,Freespace

Get-Service | Where-Object -Property Status -Contains 'Running' | Format-Table -Property Status,DisplayName