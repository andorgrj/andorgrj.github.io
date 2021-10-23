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