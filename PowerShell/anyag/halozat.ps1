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

ipconfig -all

tracert -4 rovision.ro

ping -a 185.146.87.199

ping localhost

Test-NetConnection

Get-NetAdapter | Where-Object -Property Name -EQ Ethernet

arp -a

route print -4

mstsc # távoli asztali kapcsolat
ncpa.cpl # hálózati kapcsolatok

nslookup progmasters.hu

nslookup -type=ns progmasters.hu #nameserverek

nslookup -type=soa progmasters.hu #start of authority

nslookup -query=mx progmasters.hu #mail record

Get-DnsClientCache #dns cache 
ipconfig /flushdns #dns cache törlése

netstat -n -o

Resolve-DnsName  ------> u.a. mint az nslookup de használhatóbb formát ad vissza

Resolve-DnsName -Name gmail.com -Type MX

Get-Command -Noun "DNS*"



