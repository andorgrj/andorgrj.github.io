Get-Disk

$a = Get-Disk

$a | Select-Object -Property Number, HealthStatus

Get-Service | Where-Object {$_.Status -eq 'Running'}
Get-Service | Where-Object Status -EQ Running



Get-Command -Noun Process
Get-Command -Noun Service


Get-Service
Get-Service | Out-File C:\Users\admin\Desktop\elso.txt
notepad C:\Users\admin\Desktop\elso.txt
Remove-Item C:\Users\admin\Desktop\elso.txt 


Get-Service | Where-Object {$_.Status -eq 'Running'} | Out-File C:\Users\admin\Desktop\masodik.csv
Remove-Item C:\Users\admin\Desktop\masodik.txt
notepad C:\Users\admin\Desktop\masodik.csv

Get-Service | Where-Object {$_.Status -eq 'Running'} | Export-Csv C:\Users\admin\Desktop\service.csv
notepad C:\Users\admin\Desktop\service.csv
Remove-Item C:\Users\admin\Desktop\service.csv


Get-Service | ConvertTo-Html C:\Users\admin\Desktop\service.html
Get-Service | ConvertTo-Html | Out-File C:\Users\admin\Desktop\service.html
Remove-Item C:\Users\admin\Desktop\service.csv

Get-Service | ConvertTo-Json | Out-File C:\Users\admin\Desktop\service.json
notepad C:\Users\admin\Desktop\service.json

Get-Service -Name BITS
Get-Help Start-Service -ShowWindow

$a = "Berlin"
$b = "Vienna"

$a | foreach {Read-Host "This is $_."} 
$a | foreach {Write-Host "This is $PSItem" -ForegroundColor red -BackgroundColor Yellow}
$b | foreach {Read-Host "This is $_."}
$b | foreach {Write-Host "This is $PSItem" -ForegroundColor red -BackgroundColor Green}

Get-PSDrive | Where-Object {$_.Free -gt 1} | ForEach-Object { Write-Host "Free Space for" $_.Root "is" ($_.Free/1gb) -ForegroundColor Red}
"{0:N0}" -f 1000
"{0:N2}" -f 1000
"{0:c2}" -f 1000
"{0:p2}" -f 1000

Test-NetConnection
Get-Help Tracert
Get-NetAdapter
$m = Get-NetAdapterAdvancedProperty 
$m | Get-Member
$m.SystemName


Get-NetAdapter | Where-Object {$PSItem.Name -eq 'Ethernet'} | Select-Object -Property Status, MacAdress



Get-NetIPAddress | Sort-Object -Property Name, Status, MacAdress | Format-Table

Get-NetAdapter | Sort-Object -Property Name, Status, MacAdress | Format-Table
$x = Get-NetIPAddress
$x | Get-Member
Get-NetIPAddress | Format-Table



Get-NetAdapter | Sort-Object -Property Name, Status, MacAdress | Format-Table
Get-NetAdapter | Where-Object Name -eq Ethernet | Sort-Object -Property Name, MacAdress
#Get-NetAdapter | Where-Object {$PSItem.Name -eq 'Ethernet'} | Select-Object -Property Status, MacAdress


Get-NetIPAddress | Format-Table
$q = Get-NetIPAddress
Get-NetIPAddress | Where-Object -Property PrefixOrigin -eq DHCP | Format-Table
Get-NetAdapter | Where-Object Name -eq Ethernet | Sort-Object -Property Name, MacAdress


$ifIndex = (Get-NetAdapter -Name "Wi-Fi 2").ifIndex
$ifIndex2 = Get-NetIPAddress | Where-Object InterfaceIndex -eq $ifIndex
$ifIndex3 = $ifIndex2 | Where-Object Addressfamily -eq "IPv4"
$ifIndex3 | Format-Table -AutoSize

$a=(get-netipaddress | where-object{($_.interfacealias -eq "Wi-Fi") -and ($_.addressfamily -eq "IPv4")}).interfaceindex
(get-netipaddress | where-object{($_.interfaceindex -eq $a) -and ($_.addressfamily -eq "IPv4")}).ipaddress

Get-NetAdapterStatistics -InterfaceAlias Ethernet




$q = Get-NetIPAddress
$q | Where-Object -Property PrefixOrigin -eq DHCP | Format-Table
Get-NetAdapter | Where-Object Name -eq Ethernet | Sort-Object -Property Name, MacAdress


---------------------------------------------------------------------------------------------------------------------------------------------------------

$x = [int] (Read-Host "Add meg,hogy hány sor magas legyen a háromszög") 
for($i=1; $i -le $x; $i++){ 
   
   for($k=1; $k -le $x -$i; $k++ ){
      Write-Host -NoNewLine " "
   }

   for($j=1; $j -le 2 * $i - 1; $j++){ 
     Write-Host -NoNewLine "*" 
   }

   Write-Host " "
}

------------------------------------------------------------------------------------------------------------------------------------------------------------
Custom Property létrehozása  @{n='neve' ;e={$PSItem.}} /nevet adok neki, psitem itt a computerinfoból érkező adatok közül a csdnhost, ami a gépnevet jelenti 

Get-ComputerInfo | Select-Object @{n='ComputerName' ;e={$PSItem.CsDNSHostName}}

------------------------------------------------------------------------------------------------------------------------------------------------------------
For ciklus és számok

# Kiürítem a képernyőt
Clear-Host;
# Kell egy random szám 1-10 = $number
$number = Get-Random -Maximum 11;
# kiírom a választott számot
Write-Host "A(z) $number a véletlenszerűen választott szám.`n";

# for $i 1-től 10-ig
For ($i=1; $i -le 10; $i++) {
#   szorzás elvégzése
    $result = $i * $number;
#   kiírni az adott sort
    Write-Host "$i * $number = $result";
# endfor
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------