Keresse meg azokat a parancsokat, amelyek tartalmazzák a „resolve” kifejezést és vizsgálja meg a különböző kereséshez használatos cmdlet-ek kimeneteit:

Get-Help *resolve* 
Get-Command *resolve* 
Get-Help -Verb *resolve* 

-------------------------------------------------------------------------------------------------------------------------------

Get-Help *adapter* 
Get-Command *adapter* 
Get-Command -Noun *adapter*
Get-Command -Verb Set -Noun *adapter*

Get-Help *branch*

-------------------------------------------------------------------------------------------------------------------------------
Security eseménynapló lekérdezése, adott ID-val rendelkező bejegyzésekre szűrve

Get-EventLog -LogName Security | Where EventID -eq 4624 | Measure-Object | fw
Get-EventLog -LogName Security | Where EventID -eq 4624 | Select TimeWritten,EventID,Message
Get-EventLog -LogName Security | Where EventID -eq 4624 |Select TimeWritten,EventID,Message -Last 10 | fl

-------------------------------------------------------------------------------------------------------------------------------
Tanusítványok lekérdezése és szűrése

Get-ChildItem -Path CERT: -Recurse
Get-ChildItem -Path CERT: -Recurse | Get-Member
Get-ChildItem -Path CERT: -Recurse | Where HasPrivateKey -eq $False | Select-Object -Property FriendlyName,Issuer | fl
Get-ChildItem -Path CERT: -Recurse |Where { $PSItem.HasPrivateKey -eq $False -and $PSItem.NotAfter -gt (Get-Date) -and $PSItem.NotBefore -lt (Get-Date) } | Select-Object -Property NotBefore,NotAfter, FriendlyName,Issuer | ft -wrap

-------------------------------------------------------------------------------------------------------------------------------
Kevés hellyel rendelkező meghajtók lekérdezése


Get-Volume
Get-Volume | Get-Member
Get-Volume | Where-Object { $PSItem.SizeRemaining -gt 0 } | fl
Get-Volume | Where-Object { $PSItem.SizeRemaining -gt 0 -and $PSItem.SizeRemaining / $PSItem.Size -lt .99 }| Select-Object DriveLetter, @{n='Size';e={'{0:N2}' -f ($PSItem.Size/1MB)}}
Get-Volume | Where-Object { $PSItem.SizeRemaining -gt 0 -and $PSItem.SizeRemaining / $PSItem.Size -lt .1 }

-------------------------------------------------------------------------------------------------------------------------------
Vezérlőpult elemeinek lekérése

help *control*
Get-ControlPanelItem 
Get-ControlPanelItem -Category 'System and Security' | Sort Name 
Get-ControlPanelItem -Category 'System and Security' | Where-Object -FilterScript {- not ($PSItem.Category -notlike '*System and Security*')} | Sort Name

-------------------------------------------------------------------------------------------------------------------------------
Meghajtó fájlainak lekérése

Get-ChildItem -Path C: -Recurse 
Get-ChildItem -Path C: -Recurse | Get-Member 
Get-ChildItem -Path C: -Recurse | ForEach GetFiles

-------------------------------------------------------------------------------------------------------------------------------
100 darab random szám generálása

help *random*
help Get-Random –ShowWindow
1..100 
1..100 |
ForEach { Get-Random –SetSeed $PSItem }

-------------------------------------------------------------------------------------------------------------------------------
WMI-n keresztül a gép újraindítása. Az utolsó parancs kiadásánál újraindul a gép, így ments el mindent a parancs kiadása előtt.

Get-WmiObject –Class Win32_OperatingSystem -EnableAllPrivileges
Get-WmiObject –Class Win32_OperatingSystem -EnableAllPrivileges | Get-Member
A következő parancs kiadásánál újraindul a gép. Mentsen el mindent.
Get-WmiObject –Class Win32_OperatingSystem -EnableAllPrivileges | ForEach #Reboot

-------------------------------------------------------------------------------------------------------------------------------
Service-k mentése különböző formátumokba

Get-Service | ConvertTo-Html |Out-File  c:\services.html
Get-Service | Export-Csv c:\services.csv
Get-Service | ConverTo-JSON | Out-File c:\services.json

-------------------------------------------------------------------------------------------------------------------------------
Kössük Get-Service és Get-Eventlog parancsok -ComputerName paraméteréhez a Get-ComputerInfo CsDnsHostName property-jét

Get-ComputerInfo | select CsDNSHostname
Get-Service –ComputerName (Get-ComputerInfo | select CsDNSHostname -ExpandProperty CsDNSHostName)
Get-ComputerInfo | Select @{n='ComputerName';e={$PSItem.CsDNSHostName}} | Get-Service –Name *Get-ComputerInfo  | Select @{n='ComputerName';e={$PSItem.CsDNSHostName}} | Get-WmiObject –Class Win32_BIOS
Get-EventLog –LogName Security –ComputerName (Get-ComputerInfo | select -ExpandProperty CsDNSHostName) -Newest 30

-------------------------------------------------------------------------------------------------------------------------------
Könyvtár létrehozása, PSDrive felcsatolása és fájl létrehozása

Get-Help New-Item –ShowWindow
New-Item –Path „c:\” –Name ShareDir –ItemType Directory
Get-Help New-PSDrive –ShowWindow
New-PSDrive –Name ShareDir –Root „C:\ShareDir” –PSProvider FileSystem
Get-Help Set-Location -ShowWindow 
Set-Location ShareDir:
New-Item test.txt
Get-ChildItem

-------------------------------------------------------------------------------------------------------------------------------
Registry kezelése

Get-ChildItem -Path HKCU:\Software 
New-Item -Path HKCU:\Software -Name Apps 
Set-Location HKCU:\Software\Apps 
New-ItemProperty -Path HKCU:\Software\Apps -Name "AppDir" –Value "ShareDir"
Get-ItemProperty . -Name AppDir

-------------------------------------------------------------------------------------------------------------------------------
Változók

$scriptPath = "C:\Logs\"
$scriptPath.GetType()
$scriptPath | Get-Member
$scriptFile = "myscript.ps1"
$scriptPath += $ scriptFile
$scriptPath
$scriptPath.Replace("C:","D:")
$scriptPath
$scriptPath = $scriptPath.Replace("C:","D:")
$scriptPath

------------------------------------------------------------------------------------------------------------------------------
DateTime típusú változók

$today = Get-Date
$today.GetType()
$today | Get-Member
$logFileName = [string]$today.Year + "-" + $today.Month + "-" + $today.Day + "-" + $today.Hour + "-" + $today.Minute + ".log"
$theDayAfterTomorrow = $today.AddDays(2)
$today
$theDayBeforeYesterday = $today.AddDays(-2)
$today

-----------------------------------------------------------------------------------------------------------------------------
ArrayList

[System.Collections.ArrayList]$servers = "WEB01","WEB02","SQL01", „SQL02”
$servers
$servers.IsFixedSize
$servers.Add(„SERV01”)
$servers
$servers.Remove(„WEB02”)
$servers
