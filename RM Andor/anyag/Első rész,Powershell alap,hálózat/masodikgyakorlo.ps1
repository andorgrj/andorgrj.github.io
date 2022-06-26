Get-Windowsoptionalfeature -Online | Where-Object {$_.FeatureName -like "*Windows*"}

Disable-WindowsOptionalFeature -Online -FeatureName TelnetClient

Get-Command -Noun Process
Get-Command -Noun WindowsOptionalFeature


Get-Process | Where-Object {$_.ProcessName -like "*powershell*"}
Get-Service | Where-Object {$_.Status -eq "Running"}
$a = Get-Service | Where-Object {$_.Name -eq "wmiApSrv"}

Get-Service | Where-Object {$_.Name -like "*wmi*"}

Set-Service -Name wmiApSrv -StartupType Disabled
Set-Service wmiApSrv -StartupType Disabled
Set-Service -InputObject $a -StartupType Automatic

Get-Process | Where-Object {$_.ProcessName -like "*wmi*"}

---------------------------------------------------------------------------------------------


$hash = @{ Number = 1; Shape = "Square"; Color = "Blue"}         

$hash = [ordered]@{ Number = 1; Shape = "Square"; Color = "Blue"}

$hash.keys
$hash.values
$hash.count

$hash.Add("Time", "Now") 

$t = "Today"    
$now = (Get-Date)
$hash.Add($t, $now)

$hash.Remove("Time")  


----------------------------------------------------------------------------------------------

Get-PSDrive | ?{$_.Free -gt 1} | %{$Count = 0; Write-Host "";} { $_.Name + ": Used: " + "{0:N2}" -f ($_.Used/1gb) + " Free: " + "{0:N2}" -f ($_.free/1gb) + " Total: " + "{0:N2}" -f (($_.Used/1gb)+($_.Free/1gb)); $Count = $Count + $_.Free;}{Write-Host"";Write-Host "Total Free Space " ("{0:N2}" -f ($Count/1gb)) -backgroundcolor green}