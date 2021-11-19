Szolgáltatás indítás / itt a kézzel indítható és leállítható wmi nevű szolgáltatást indítottam el

$a = Get-Service | Where-Object {$_.Name -eq "wmiApSrv"}
$a.Status
$a.StartType
$a.DisplayName

Start-Service $a ---->itt indítom
Get-Service | Where-Object {$_.Name -eq "wmiApSrv"}
$a.Status
Stop-Service $a -----> itt állítom le
$a.Status


Set-Service -Name wmiApSrv -StartupType Disabled    ---------> indítás módját állítom be
Set-Service -InputObject $a -StartupType Automatic   --------> ez ugyanaz csak más forma a parancs



------------------------------------------------------------------------------------------------------------------------------------------------------------
Szolgáltatások be és kikapcsolás

get-windowsoptionalfeature -Online | Where-Object {$_.FeatureName -like "*Linux*"}
Disable-WindowsOptionalFeature -Online -FeatureName TelnetClient

Get-Command -Noun Process
Get-Command -Noun Service
Get-Command -Noun WindowsOptionalFeature


Get-Process | Where-Object {$_.ProcessName -like "*powershell*"}
Get-Service | Where-Object {$_.Status -eq "Running"}
$a = Get-Service | Where-Object {$_.Name -eq "wmiApSrv"}

Get-Service | Where-Object {$_.Name -like "*wmi*"}

Set-Service -Name wmiApSrv -StartupType Disabled
Set-Service wmiApSrv -StartupType Disabled
Set-Service -InputObject $a -StartupType Automatic

Get-Process | Where-Object {$_.ProcessName -like "*wmi*"}




Get-Command -Noun Process
Get-Command -Noun Service
Get-Command -Noun WindowsOptionalFeature

Get-Service | Where-Object Status -EQ Running

