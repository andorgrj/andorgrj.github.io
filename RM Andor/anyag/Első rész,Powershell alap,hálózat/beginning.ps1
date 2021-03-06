
# 1 

$PSVersionTable

$ci = Get-ComputerInfo  -Property BiosName
$ci
Get-Command -Verb Get
Get-Command -Noun Computer*
Get-Help -Name Get-Computerinfo -full








#2

Get-Command

Get-Command a úgy lett kialakítva, hogy segítsen megkeresni a parancsokat.
A Get-Command a rendszeren lévő összes parancs listáját adja vissza.

# Néhány formátum ahogy a hivatalos segítség elérhető:
Get-Help -Name Get-Command -Full
Get-Help -Name Get-Command -Online
Get-Help -Name Get-Command -Detailed
Get-Help -Name Get-Command -ShowWindow

https://docs.microsoft.com/hu-hu/powershell/scripting/learn/ps101/02-help-system?view=powershell-7
#>

#1. 
Get-Command 
Get-Command -Name *LocalU*
Get-Command -Name Get-Local*

Get-Command -Name Get-ExecutionPolicy | Select-Object *
$parancs = Get-Command Set-ExecutionPolicy

$parancs.Module
$parancs.DLL
$parancs.Version

<# 
2. Biztos észrevettétek, hogy a powershell parancsok egy IGE-FŐNÉV (Verb-Noun) kombinációból állnak. 
Vegyük az ismert példákat:
Get-LocalUser:          Get - Ige(verb)    LocalUser - Főnév(noun)
Add-LoclaGroupMember:   Add - Ige          LocalGroupMember - Főnév 
Set-ExecutionPolicy:    Set - Ige          ExecutionPolicy - Főnév

Kérdezzük le a Localuser főnévhez tartozó összes igét(verb) hogy milyen parancsok léteznek (mit tudunk csináni a helyi felhasználó fiókokkal):
#>
Get-Command -noun LocalUser

#3. Nézzük milyen Főnevek léteznek pl az "Add" -hoz: (jó hosszú lista)
Get-Command -verb Add

#4. Lekérdezhetjük csak az igéket (verb). Illetve egy egyszerűen meg is számolom őket, de ez 1 másik napi powershell óra része lesz...
Get-Verb
(Get-Verb).length

#5. Nézzük a gyakorlati hasznát, Néhány példával:
Get-Command -Noun Command       #Get: ige, Command: főnév
Get-Command -Noun Process       #Mit csinálhatunk a futó folyamatokkal (Get-Process)
Get-Command -Noun Service       #Mit csinálhatunk a szolgáltatásokkal (Get-Services)

Get-Command -Verb Find          #Mely parancsokanak létezik Find- előtagja
Get-Command -Verb New
Get-Command -Noun WindowsOptionalFeature
Get-Windowsoptionalfeature -Online | Where-Object {$_.FeatureName -like "*Windows*"}







$udvozloszoveg = "Szia"
$kivagyok = Read-Host -Prompt "Neved: "
$jelszo = Read-Host -Prompt "Jelszó: " -AsSecureString

Write-Host $udvozloszoveg + $kivagyok
Write-Host "$udvozloszoveg $kivagyok!"
Write-Host "$udvozloszoveg $kivagyok!" 
Write-Host "$udvozloszoveg $kivagyok!" -ForegroundColor Green -BackgroundColor Yellow
Write-Host $jelszo 






Get-Date
Get-Date | Get-Member
(Get-Date).Day
(Get-Date).DayOfWeek





$info = Get-ComputerInfo
write-Host $info.OsName -ForegroundColor Black -BackgroundColor Yellow
$info = Get-ComputerInfo
write-Host "OS tipusa:" ($info).OsName -ForegroundColor Black -BackgroundColor Yellow
$info Get-Member
$info.ToString()

get Timezone
Get-Date
$Host
$a = 10
$b = 10
$c = $a + $b
Write-Host $c





$a = "Szia"
$b = " Andor vagyok"
$c = Get-Date
$d = "Andor" 
write-Host ($a + $b)
Write-Host "$a" -ForegroundColor Green -BackgroundColor red $d






Környezeti változó hozzáadása

$env:valamivaltozo = "valamiertek"
meglévő bővítése
$env:Path += ";C:\aa"

Rendszer szintű (.net objektumrendszer használatával)
[System.Environment]::SetEnvironmentVariable('valamivaltozo','valamiertek')

How to set environment variables using powershell








<# script futtatás engedélyezés #>
Get-ExecutionPolicy -List

<#
Scope ExecutionPolicy
----- ---------------
MachinePolicy       Undefined
UserPolicy       Undefined
Process    RemoteSigned
CurrentUser       Undefined
LocalMachine    RemoteSigned
#>

#Az összeset undefined-ra állítja
Set-ExecutionPolicy Undefined

# -Scope adat alapján 1-1 hozzáférés állítása
Set-ExecutionPolicy Undefined -Scope Process
Set-ExecutionPolicy Restricted -Scope LocalMachine
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser