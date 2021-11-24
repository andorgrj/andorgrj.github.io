----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Hozzáférések eltárolása biztonságos módon egy fájlban és visszaolvasása


$Credential = Get-Credential
$Credential | Export-CliXml -Path C:\Users\Andor\ifksp\cred.txt

$import = Import-CliXml -Path C:\Users\Andor\ifksp\cred.txt

https://www.jaapbrasser.com/quickly-and-securely-storing-your-credentials-powershell/


--------------------------------------------------------------method2
$Path = "$HOME\.ssh\creds.txt"
$Credential = Get-Credential
if (Test-Path $Path) {
    $Credential_old = Import-CliXml -Path $Path
    $Hash = @{ Old = $Credential_old; New = $Credential }
    $Hash | Export-CliXml -Path $Path}
else {$Credential | Export-CliXml -Path $Path}
-------------------------------------------------------------method3

$credential = Get-Credential;
-join($credential.UserName,',',($credential.Password | ConvertFrom-SecureString)) | Add-Content -Path "$env:USERPROFILE.ssh\creds.txt"

--------------------------------------------------------------------method4
$credential = Get-Credential
$path = Join-Path $env:USERPROFILE "\.ssh\creds.txt"
If (Test-Path $path){
$credContent = Get-Content -Path $path
$credential | Export-Clixml -Path $path
Add-Content -Path $path -Value $credContent
}
Else{
$credential | Export-Clixml -Path $path
}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Számítógéphez csatlakozás számának megtekintése/Kiváncsi vagyok kik, honnan, és mikor csatlakoztak távoli asztallal egy számítógéphez.



$Events = Get-WinEvent -logname "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" | where {($_.Id -eq "21" -OR $_.Id -eq "24" -OR $_.Id -eq "25"  -OR $_.Id -eq "23")}
$Results = Foreach ($Event in $Events) {
  $Result = "" | Select Message,User,TimeCreated
  $Result.TimeCreated = $Event.TimeCreated
  Foreach ($MsgElement in ($Event.Message -split "`n")) {
    $Element = $MsgElement -split ":"
    If ($Element[0] -like "Felhaszn?l?") {$Result.User = $Element[1].Trim(" ")}
    If ($Element[0] -like "T?voli asztali szolg?ltat?sok*") {$Result.Message = $Element[1].Trim(" ")}
  }
  $Result
} 
$Results | Select Message,User,TimeCreated |Out-GridView 

https://www.red-gate.com/simple-talk/sysadmin/powershell/powershell-day-to-day-sysadmin-tasks-securing-scripts/
-------------------------------------------------------------

Get-WinEvent -FilterHashtable @{Logname='System';ID=7001,7002,3261,4624}| Select-Object ID,@{l='Category';e={Switch($_.ID){
    "7001" {"Logon"}
    "7002" {"Logoff"}
    "3261" {"JoinToWorkgroup"}
    "4624" {"*"}
    }
}},@{label='Time Created';expression={$_.TimeCreated.ToString("yyyy-M-d HH:mm:ss")}},Message | ft -autosize

------------------------------------------------------------


$Events = Get-WinEvent -logname "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" | where {($_.Id -eq "21" -OR $_.Id -eq "24" -OR $_.Id -eq "25"  -OR $_.Id -eq "23")}


------------------------------------------------------------

$UserProperty = @{n="user";e={(New-Object System.Security.Principal.SecurityIdentifier $_.ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])}}
$TypeProperty = @{n="Action";e={if($_.EventID -eq 7001) {"Logon"} else {"Logoff"}}}
$TimeProeprty = @{n="Time";e={$_.TimeGenerated}}
Get-EventLog System -Source Microsoft-Windows-Winlogon | select $UserProperty,$TypeProperty,$TimeProeprty |OUT-Gridview


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CIM instacne - win os adatok (kiadás, verzió, telepítési ideje, buildszáma), saját gépemről, majd 1 távoliról

#Core
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName 10.0.0.5 | Select-Object -Property Version,InstallDate,BuildNumber,OSType,CSName | Format-Table | Out-String  ->itt a belső ip címet beleírom

#GUI
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property Version,InstallDate,BuildNumber,OSType,CSname | Format-Table | Out-String


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Alerts

$UserProperty = @{n="user";e={(New-Object System.Security.Principal.SecurityIdentifier $_.ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])}}
$TypeProperty = @{n="Action";e={if($_.EventID -eq 7001) {"Logon"} else {"Logoff"}}}
$TimeProeprty = @{n="Time";e={$_.TimeGenerated}}
Get-EventLog System -Source Microsoft-Windows-Winlogon | select $UserProperty,$TypeProperty,$TimeProeprty |OUT-Gridview

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Window updatek kilistázása

Get-WmiObject -class win32_quickfixengineering | Sort-Object -Descending | OUT-Gridview