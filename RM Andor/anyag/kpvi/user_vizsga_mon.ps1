1.
foreach ($service in $services)
{
    $count = $count+ 1
    Write-Host "$count : futó szolgáltatás: $($service.Name)"
}

$services = Get-Service
Write-Host "Jelenleg futó szolgáltatások száma: $($services.Count)"


2.
$users = Get-LocalUser | Where-Object -Property Enabled -Like True

$a = Get-LocalUser
$a | Select-Object -Property Name, Enabled

3.
$userslist = ForEach ($userlist in $(Get-Content C:\Users\users.txt))

4.
Resolve-DnsName -Type SOA progmasters.hu -Server 8.8.8.8
Resolve-DnsName -Type TXT progmasters.hu -Server 8.8.8.8

5.
Get-LocalUser | Select-Object -Property Name,LastLogon | Where-Object -Property LastLogon -NE $null

6.
Get-NetAdapter | Get-NetIPAddress | Where-Object AddressFamily -eq IPv4 | Select-Object InterfaceAlias,IPaddress | Format-Table

7.
$process1 = Get-Process | Where-Object {$_.Id -eq '5100'}
$process2 = Get-Process | Where-Object {$_.Id -eq '3988'}

Clear-Host
Write-Host $process1 
Write-Host $process2

8.
Get-Process | Sort-Object -Property CPU -Descending

9.
Get-NetFirewallRule -Direction Inbound