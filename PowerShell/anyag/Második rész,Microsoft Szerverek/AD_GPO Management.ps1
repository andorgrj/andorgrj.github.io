Ellenőrzés, hogy a gép benne van-e a domainbe: 

Desktop -> Services -> Nettwork Location Awareness -> Restart

https://www.vkernel.ro/blog/steps-to-check-if-domain-controller-was-properly-promoted

--------------------------------------------------------------------------------------------
Group Policy management

Default Domain Policy a fő - ezt nem írjuk át soha, ez alá kerül be az egyéni

Megosztott könytárak készítése: tetszőleges könyvtár jobbegér -> properties -> share -> domain users
    ennek ellenőrzése: \\gandorWS2019 a file explorer elérési útvonalába írva

Új felhasználó létrehozása, groupba rendezése, win10 gépbe be lehet vele lépni



https://viktortaylor.wordpress.com/hirek-esemenyek/csoport-hazirend-group-policy/
https://hu.wikipedia.org/wiki/Csoporth%C3%A1zirend
-----------------------------------------------------------------------------------------------------------
Meghajtócsatlakoztatás

Group and Policy Object -> New GPO -> pl PDrive -> jobb gomb/edit -> Preferencies/Windows Settings/Drive Map -> New Mapped Drive / Reconnect -> Location: \\gandorWS2019\Peldashare
ha ez kész -> gpupdate/ force -> server és Win10 gépen

-----------------------------------------------------------------------------------------------------------
Ikon készítése

Group and Policy Object -> New GPO -> pl PMIkon -> jobb gomb/edit -> Preferencies/Windows Settings/Shortcuts -> New Shortcut -> Location/targetpath and settings
ha ez kész -> gpupdate/ force -> server és Win10 gépen




-----------------------------------------------------------------------------------------------------------

ping gandor.local

dcdiag   ->domain controllel leellenőrzése
dcdiag -v
dcdiag /test:DNS
dcdiag /test:connectivity -v > C:\Peldashare\aa.txt


Get-DnsClientServerAddress
Get-DnsClient
Get-ADDomainController | Select-Object OperationMasterRoles
Get-ADDomainController | Select -ExpandProperty OperationMasterRoles

$Env:USERDNSDOMAIN
(Get-ADDomain -Server $env:userdnsdomain).DistinguishedName

Get-AdDomain
Get-ADForest
Get-ADRootDSE
(Get-ADRootDSE).schemaNamingContext
(Get-ADRootDSE).namingContexts

get-adobject -filter 'objectclass -eq "group"'
get-adobject -filter * | Where-Object {$_.objectclass -eq 'Computer'}
get-adobject -filter * | Where-Object {$_.objectclass -eq 'User'}
get-adobject -filter * | Where-Object {$_.objectclass -eq 'Group'}
get-adobject -filter * | Where-Object {$_.objectclass -eq 'secret'}
get-adobject -filter * | Where-Object {$_.objectclass -eq 'organizationalUnit'}
get-adobject -filter * | Where-Object {$_.objectclass -eq 'groupPolicyContainer'}
get-adobject -filter * | Where-Object {$_.objectclass -eq 'DomainPolicy'}


#ADDS Deployment
Test-ADDSDomainControllerInstallation

----------------------------------------------------------------------------------------------------------

