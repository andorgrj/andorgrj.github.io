$name = "Andor"
$date = Get-Date
$computerinfo = Get-ComputerInfo | Select-Object CsName
$info = "***  
*  
* Nevem : $name  
* Dátum : $date  
* Számítógép : $computerinfo  
*  
***  "
$filePath = "C:\feladat\vizsga2022_mon\vizsga_monitor.txt"
$info | Out-File -FilePath $filePath

Get-NetAdapter | Get-NetIPAddress | Where-Object AddressFamily -eq IPv4 | Select-Object InterfaceAlias,IPaddress | Format-Table | Out-File -FilePath $filePath -Append
Get-LocalGroup | Select-Object -Property Name | Out-File -FilePath $filePath -Append
$users = Get-LocalUser | Where-Object -Property Enabled -Like True | Out-File -FilePath $filePath -Append
Get-NetFirewallRule -Direction Inbound | Out-File -FilePath $filePath -Append

New-Item -Path "C:\feladat\vizsga2022_mon" -Name "szoveg" -ItemType "directory"
Copy-Item "C:\Windows\System32\winevt\*.txt" -Destination "C:\feladat\vizsga2022_mon\szoveg"

$path = "C:\feladat\vizsga2022_mon"
New-Item -Path "$path\web" -ItemType Directory
New-Item -Path "$path\web\main.html" -ItemType File
Add-Content -Path "$path\web\main.html" -Value "Záró vizsga"

New-Item -Path "C:\feladat\vizsga2022_mon" -Name "web" -ItemType "directory"
New-Item -Path "C:\feladat\vizsga2022_mon\web" -Name "main.html" -ItemType "file"
Add-Content -Path "C:\feladat\vizsga2022_mon\web\main.html" -Value "Záró vizsga"

Remove-Item -Path C:\feladat -Recurse

Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

A feladat elkészítéséhez egyaránt használható Windowsos és Linuxos környezet.

A feladat, hogy hozz létre egy szkriptet, ami képes az alábbi feladatok elvégzésére. Feltételezhetjük, hogy a szkriptet adminisztrátori jogosultsággal futtatjuk, ezért erre nem kell külön figyelmet fordítani.

Beadandó fájl neve: user_vizsga_mon.ps1 vagy user_vizsga_mon.sh

Összesen elérhető: 20 pont

1. feladat

Készíts 1 új fájlt vizsga_monitor.txt néven. A következő könyvtárba dolgozz ez lesz a munkamappád:
- Elérési út Windowsos környezetben: C:\feladat\vizsga2022_mon
- Elérési út Linuxos környezetben: /home/vizsga2022_mon

Tartalmazza a következő sorokat:

***  
*  
* Nevem : saját_név  
* Dátum : éééé.hh.nn  
* Számítógép : hostnév  
*  
***  
A fájlban a saját neved és az aktuális dátum szerepeljen. a részfeladatért maximális pont akkor jár, ha ezt scripttel hozod létre és az értékek is lekérdezésből származnak (a saját neved nem).

2. feladat Az 1. pontban létrejött fájlhoz fűzd hozzá a számítógép IPv4 címeit

3. feladat Az 1. pontban létrejött fájlhoz fűzd hozzá a számítógépen található lokális csoportokat és az engedélyezett lokális felhasználókat

4. feladat Az 1. pontban létrejött fájlhoz fűzd hozzá a számítógép bejövő (inbound) tűzfal szabályait.

5. feladat
Hozz létre 1 új könyvtárat a munkamappádba. Neve: szoveg
Másold át az összes .txt fájlt a szoveg mappádba az alábbi mappákból és alkönyvtáraikból:
- linux alatt /var
- windows alatt C:\Windows\System32\winevt

6. feladat
Készíts 1 új mappát a munkakönyvtáradba. Neve: web
A web mappába készíts 1 új fájlt : main.html
Másold bele a következő szöveget: Záró vizsga
Csak scriptel készített fájl elfogadható.

7. feladat Töröld a munkamappád tartalmát almappákkal együtt

8. feladat Tiltsd le a számítógép tűzfalát


