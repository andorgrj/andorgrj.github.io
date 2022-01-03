***************************
* Simple riport
* Date: ..... (a futtatáskori aktuális dátum)
* Computer: ...... (A számítógép neve)
**************************

# Azokat a helyi felhasználókat (Nevét és utolsó belépési idejét) akiknél van utolsó belépési idő

# A hálózati kártyákat és a hozzájuk tartozó IPv4 címet.

# Listázd ki az első 5 folyamatot ami a legtöbb processzor időt használja (CPU) 
# A lista tartalmazza a folyamat nevét, a processzor időt (CPU) és a használt memóriát (WS) Megabyteban.

End riport
****************************

---------------------------------------------------------------------------------------------------------------------------------------

$date = Get-Date
$computerinfo = Get-ComputerInfo | Select-Object CsName
$user = Get-LocalUser | Where-Object -Property Lastlogon -ne $null | Select-Object Name,LastLogon | Format-Table | Out-String
$net = Get-NetAdapter | Get-NetIPAddress | Where-Object AddressFamily -eq IPv4 | Select-Object InterfaceAlias,IPaddress | Format-Table | Out-String
$process = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 | Select-Object Name,CPU,WS | Format-Table | Out-String

Clear-Host
Write-Host "

***************************
* Simple riport
* Date: $date
* Computer: $computerinfo
**************************



$user

$net

$process 

End riport
****************************
"

---------------------------------------------------------------------------------------------------------------------------------------

Clear-Host
Write-Host "*************************************************************************************" 
Write-Host "Simple Report"
Get-Date
$info = Get-ComputerInfo
write-Host "A számítógép neve:" ($info).CsName
Get-LocalUser | Select-Object Name,Lastlogon | Format-List
$net = Get-NetIPAddress
$net | Where-Object -Property PrefixOrigin -eq DHCP | Format-Table
#vagy a Net-Adapter segítségével
Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 5 
Write-Host "End riport"
Write-Host "************************************************************************************"


@{Name="GB";Expression={$_.size/1GB}}   -----> érték megadása GB-ban


--------------------------------------------------------------------------------------------------------------------------------------

Get-LocalUser | Select-Object -Property Name,LastLogon | Where-Object -Property LastLogon -NE $null

Get-NetIPAddress | Select-Object -Property InterfaceAlias, IPv4Address | Where-Object -Property IPv4Address -NE $null

Get-Process | Select-Object -Property Name, TotalProcessorTime, @{N='WSSizeInMB';E={$_.WS/1MB}} | Sort-Object -Property TotalProcessorTime -Descending | Select-Object -First 5 | ft