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
ArrayList - Tömbök

[System.Collections.ArrayList]$servers = "WEB01","WEB02","SQL01", "SQL02”
$servers
$servers.IsFixedSize
$servers.Add(„SERV01”)
$servers
$servers.Remove(„WEB02”)
$servers

-----------------------------------------------------------------------------------------------------------------------------
Hash táblák

$servers=@{"WEB01"="192.168.1.100";"WEB02"="192.168.1.101";"SQL01"="192.168.1.130"}
$servers
$servers.WEB02
$servers.WEB02 = „10.10.10.30”
$servers
$servers.Add(„SQL02”;”192.168.1.140”)
$servers
$servers.Remove(„WEB01”)
$servers

-----------------------------------------------------------------------------------------------------------------------------
String, date

[array]$formatArray = @('you','values','them.')
$user = (Get-ChildItem Env:\USERNAME).Value
$date = Get-Date
"A felhasználóneved:  {0} és az idő [{1:HH}:{1:mm}:{1:ss}]" -f $user,$date
$dt = new-object dateTime 2021,03,17 , 14,09,53
write-host "A dt változó értéke: $('{0:yyyy-MM-dd HH:mm:ss}' -f $dt)"

-----------------------------------------------------------------------------------------------------------------------------
Számok

[int]$numbers = '123456'
[int]$largenumbers = '1234567890'
[decimal]$decnumbers = '9876.54'
[decimal]$percnumber = '0.7534'
[decimal]$lowpercnumber = '0.009876'
 [double]$dblnumber = '250.23'
"{0:c}" -f $numbers
"{0:d}" -f $numbers # ==> 123456
"{0:e}" -f $numbers
"{0:f}" -f $numbers
"{0:g}" -f $decnumbers
"{0:p}" -f $lowpercnumber
"{0:x}" -f $numbers
"{0:0000000000}" -f $numbers
"{0:####}" -f $decnumbers
"{0:$#,##0.00}" -f $numbers

----------------------------------------------------------------------------------------------------------------------------
Execution policy

Get-ExecutionPolicy
Set-ExecutionPolicy AllSigned
.\HelloWorld.ps1
Set-ExecutionPolicy Unrestricted
.\HelloWorld.ps1

----------------------------------------------------------------------------------------------------------------------------
Foreach

Set-Location c: 
New-Item services.txt -ItemType File 
Get-Service “BITS” | Select -ExpandProperty Name | Out-File services.txt – Append
Get-Service w32time | Select -ExpandProperty Name | Out-File services.txt – Append
Script:
$services = Get-Content services.txt

ForEach ($s in $services) {
    $name = (Get-Service $s).Name
    $name
}

---------------------------------------------------------------------------------------------------------------------------
If

Set-Location c: 
New-Item services.txt -ItemType File 
Get-Service “BITS” | Select -ExpandProperty Name | Out-File services.txt – Append
Get-Service w32time | Select -ExpandProperty Name | Out-File services.txt – Append


Script:

$services = Get-Content services.txt

ForEach ($s in $services) {
    $status = (Get-Service $s).Status
    If ($Status -ne "Running") {
        Start-Service $s
        Write-Host "Started $s"
    } Else {
        Write-Host "$s is already started"
    }
}

Script:

$freeSpace = 12GB
If ($freeSpace -le 15GB) {
    Write-Host „Kevesebb, mint 15GB hely van”
} ElseIf ($freeSpace -le 20GB) {
    Write-Host „Kevesebb, mint 20GB hely van”
} ElseIf ($freeSpace -le 30GB) {
    Write-„Kevesebb, mint 30GB hely van”
} Else {
    Write-Host „Több, mint 30GB hely van”
}

---------------------------------------------------------------------------------------------------------------------------
Switch

Script(módosítsd a $computer változót, hogy megnézd milyen eredményt kapsz): 
$computer = "LON-CL1"

$role = "ismeretlen szerepkör"
$location = "ismeretlen helyszín"

Switch -wildcard ($computer) {
    "*-CL*" {$role = "client"}
    "*-SRV*" {$role = "server"}
    "*-DC*" {$role = "domain controller"}
    "LON-*" {$location = "London"}
    "VAN-*" {$location = "Vancouver"}
    Default {"A $computer nem érvényes gépnév"}
}

Write-Host "A $computer gép a $role szerepkörben van a $location helyen"

---------------------------------------------------------------------------------------------------------------------------
Beolvasás fájlból

Script1:
Get-Content c:\computers.txt
$computers = Get-Content c:\computers.txt
$computers.count
$computers

Script2:
Import-Csv c:\users.csv
$users = Import-Csv c:\users.csv
$users.count
$users[0]
$users[0].First

Script3
Import-Clixml c:\users.xml
$usersXml = Import-Clixml c:\users.xml
$usersXml.count
$usersXml[0]
$usersXml | Get-Member
