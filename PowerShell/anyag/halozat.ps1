Hálózathoz tartozó adatok


Get-NetAdapter
Get-NetAdapterAdvancedProperty
Get-NetAdapterBinding
Get-NetAdapterHardwareInfo
Get-NetAdapterStatistics

Test-NetConnection
Get-NetConnectionProfile


$q = Get-NetIPAddress
$q | Where-Object -Property PrefixOrigin -eq DHCP | Format-Table
Get-NetAdapter | Where-Object Name -eq Ethernet | Sort-Object -Property Name, MacAdress


-----------------------------------------------------------------------------------------------------------------------------------------------

nslookup progmasters.hu

ipconfig -all

tracert -4 rovision.ro

ping -a 185.146.87.199

ping localhost

Test-NetConnection

Get-NetAdapter | Where-Object -Property Name -EQ Ethernet

arp -a

