#Írjunk egy másik szkriptet monitor-runner néven - Az előzőt tegyük futtathatóvá / engedélyezzük a script futtatását - Az előzőt lefuttatja, és az eredményét egy result.txt fájlba írja


Set-Location $PSScriptRoot
.\user-mon.ps1 | Out-File results.txt


#Kérdezd le a progmasters.hu minden látható DNS rekordjait úgy hogy a lekérdezett névszerver a google dns szervere legyen (8.8.8.8)

#???
Resolve-DnsName -Type ANY progmasters.hu -Server 8.8.8.8
#Vagy
Resolve-DnsName -Type ALL progmasters.hu -Server 8.8.8.8 


#--írási jog az ‘vizilabdazok’ csoportnak  \vizsga2022\szakosztalyok\vizilabda
#-- Olvasási jog az ‘birkozok’ csoportnak \vizsga2022\szakosztalyok\birkozas (Powershell alatt smb és acl megoldás is elfogadható)

Get-ACL -path "vizsga2022\szakosztalyok\vizilabdazok"
(Get-ACL -Path "vizsga2022\szakosztalyok\vizilabdazok").Access | Format-Table IdentityReference,FileSystemRights,AccessControlType,IsInherited,InheritanceFlags -AutoSize
$ACL = Get-ACL -Path "vizsga2022\szakosztalyok\vizilabdazok"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("vizilabdazok","Write","Allow")
$ACL.SetAccessRule($AccessRule)
$ACL | Set-Acl -Path "vizsga2022\szakosztalyok\vizilabdazok"
(Get-ACL -Path "vizsga2022\szakosztalyok\vizilabdazok").Access | Format-Table IdentityReference,FileSystemRights,AccessControlType,IsInherited,InheritanceFlags -AutoSize


#8. Get-Process | Where-Object {$PSItem.Id -EQ 5100 -or $PSItem.Id -EQ 3988}
# 7. 
Resolve-DnsName -Server 8.8.8.8 -Name progmasters.hu -Type ALL

Get-LocalUser | Select-Object -Property Name,LastLogon | Where-Object -Property LastLogon -NE $null

Get-ComputerInfo -Property CsProcessors

Get-ComputerInfo | Select CsProcessors

Get-NetIPAddress -AddressFamily IPv6

Get-NetIPAddress -AddressFamily IPv6 | ft

Get-NetIPAddress | Where AddressFamily -EQ "IPv6"

Get-NetIPAddress | Where AddressFamily -EQ "IPv6" | Format-Table




$services = Get-Service

Write-Host "Szervizek száma: $($services.Count)"

$count = 0

foreach ($service in $services)
{
    $count = $count+ 1
    Write-Host "$count : aktuális szervíz: $($service.Name)"
}