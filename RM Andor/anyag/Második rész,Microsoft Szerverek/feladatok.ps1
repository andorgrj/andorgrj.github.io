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

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
6. heti jelenléthez/ AD adatok lekérdezése
Ezekből nyerhető ki a saját adat:

Get-AdDomain
Get-ADForest
Get-ADRootDSE
get-adobject -filter 'objectclass -eq "group"'
Get-ADOrganizationalUnit

--------------------------------------------------------------------------------------------

# Ellenörző lekérdezés
# 
# Az $sorszamom és $keresoroot változókat a helyes értékét állítsd be! 
#  a saját domain beállításaid szerint  
#

## !!!!!  
$sorszamom = "07"
$nevem = "Andor"
$keresoroot = "OU=Domain Controllers,DC=gandor,DC=local"
$userkeresoroot = "OU=gandorUsers,DC=gandor,DC=local"
$groupkeresoroot = "OU=gandorGroups,DC=gandor,DC=local"
$computerkeresoroot = "OU=gandorComputers,DC=gandor,DC=local"

$outfile = "C:\Peldashare\"+$sorszamom+"Users$(mostvan).txt" #az útvonalat (C:\Peldashare\) javítani kell, a fájl neve maradjon


$mostvan = (Get-Date -Format FileDateTime).Substring(0,15)
$logstring = @("","----------------------------------------------", "", "Név: $nevem","Sorszám :$sorszamom", "Készült: $mostvan") 

#Létrejön a log file
$logstring | Out-File $outfile

$userproperties1 = "SamAccountName", "UserPrincipalName", "DistinguishedName", "CanonicalName", "ObjectGUID", "Memberof"
$userproperties2 = "SamAccountName", "Created", "Modified", "logonCount", "LastLogonDate", "LastBadPasswordAttempt", "PasswordExpired", "PasswordLastSet", "PasswordNeverExpires", "PasswordNotRequired", "ProtectedFromAccidentalDeletion"
$userproperties3 = "SamAccountName", "DisplayName", "Description", "StreetAddress", "State", "City", "PostalCode", "Country", "Title", "Department", "Manager"

$groupproperties1 = "SamAccountName", "DistinguishedName", "CanonicalName", "ObjectGUID", "ProtectedFromAccidentalDeletion" 
$groupproperties2 = "SamAccountName", "Created", "Modified", "Members"

$computerproperties1 = "CN", "OperatingSystem","DistinguishedName", "CanonicalName", "ObjectGUID", "ProtectedFromAccidentalDeletion" 
$computerproperties2 = "CN", "Created", "Modified", "logonCount", "LastLogonDate", "LastBadPasswordAttempt", "PasswordExpired", "PasswordLastSet", "PasswordNeverExpires", "PasswordNotRequired", "ProtectedFromAccidentalDeletion"

# Lekérdezések
$users = Get-ADUser -SearchBase $userkeresoroot -Filter * -Properties *
$groups = Get-ADGroup -SearchBase $groupkeresoroot -Filter * -Properties *
$computers = Get-ADComputer -SearchBase $computerkeresoroot -Filter * -Properties *

# Kiiratás
$logstring = @("","---------------------------------------------------- User adatok ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

$users | Sort-Object SamaccountName | Select-Object $userproperties1 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append
$users | Sort-Object SamaccountName | Select-Object $userproperties2 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append
$users | Sort-Object SamaccountName | Select-Object $userproperties3 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append

$logstring = @("---------------------------------------------------- Group adatok ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

$groups | Sort-Object SamaccountName | Select-Object $groupproperties1 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append
$groups | Sort-Object SamaccountName | Select-Object $groupproperties2 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append

$logstring = @("---------------------------------------------------- Computer adatok ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

$computers | Sort-Object SamaccountName | Select-Object $computerproperties1 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append
$computers | Sort-Object SamaccountName | Select-Object $computerproperties2 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append

$logstring = @("---------------------------------------------------- Házirend objektumok ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

Get-GPO -all | Select-Object DisplayName, Id, CreationTime, ModificationTime, GpoStatus | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append

$logstring = @("---------------------------------------------------- Csoportok tagjai ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

foreach ($group in $groups){ Get-ADGroupMember $group | Select-Object $group.name, name | Out-File $outfile -Append }

$logstring = @("---------------------------------------------------- Userek csoportjai ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

foreach ($user in $users) { $user.memberof | ForEach-Object { Get-ADGroup -Filter * -SearchBase $_ -Properties * | Select-Object $user.SamAccountName, Name } | Out-File $outfile -Append }

$logstring = @("---------------------------------------------------- Vége ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append