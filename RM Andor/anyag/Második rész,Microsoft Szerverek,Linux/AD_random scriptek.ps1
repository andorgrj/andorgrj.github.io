Fail login/ próbálkozások megnézése

$FailureAttempt = Get-EventLog Security | Where-Object {$_.EntryType -like "*Failure*"} | Out-GridView
$Darab = $FailureAttempt.Length

cls
Write-Host "$Darab hibás belépési próbálkozás történt a szerverre`r`n"


$PDCEmulator = (Get-ADDomain).PDCEmulator
Get-WinEvent -ComputerName $PDCEmulator -FilterHashtable @{
    LogName = 'Security'
    ID = 4625
}


get-eventlog security  | where-object {$_.EventID -eq  "4625"} | select TimeGenerated,Message |fl 
Get-WinEvent -FilterHashtable @{logname='security';id=4771;data='username'} | fl


--------------------------------------------------------------------------------------------------------
https://docs.microsoft.com/hu-hu/samples/browse/?redirectedfrom=TechNet-Gallery