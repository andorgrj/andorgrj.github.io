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

Group Policy Object -> New GPO -> pl PDrive -> jobb gomb/edit -> Preferencies/Windows Settings/Drive Map -> New Mapped Drive / Reconnect -> Location: \\gandorWS2019\Peldashare
ha ez kész -> gpupdate /force -> server és Win10 gépen

-----------------------------------------------------------------------------------------------------------
Shortcut - Ikon készítése

Group Policy Object -> New GPO -> pl PMIkon -> jobb gomb/edit -> Preferencies/Windows Settings/Shortcuts -> New Shortcut -> Location/targetpath and settings
ha ez kész -> gpupdate/ force -> server és Win10 gépen

-----------------------------------------------------------------------------------------------------------
Backup készítése

jobb egér -> backup -> hely megadása

------------------------------------------------------------------------------------------------------------
Recycle bin/Törölt elemek helye

LDAP -> connect -> bind
https://stealthbits.com/blog/active-directory-object-recovery-recycle-bin/

Beállítása:

Active Directory Administrative Center - gandor.local -> jobbgomb -> Enable Recycle Bin

Enable-ADOptionalFeature –Identity 'CN=Recycle Bin Feature,CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=gandor,DC=local' –Scope ForestOrConfigurationSet –Target 'gandor.local'
https://www.prajwaldesai.com/active-directory-recycle-bin-ad-recycle-bin/


Get-ADObject -filter 'isDeleted -eq $true -and name -ne "Deleted Objects"' -includeDeletedObjects
------------------------------------------------------------------------------------------------------------
Kvóta létrehozása

C:\ tulajdonságok -> kvóta -> beállítások megjelenítése -> kvótabejegyzések -> új kvóta


------------------------------------------------------------------------------------------------------------
GPO konténerek helye

Get-GPO -all

Get-GPO -Guid 11bef468-aa51-487f-becb-5d12275bfe71 | Select *

Sytem -> Policies

-----------------------------------------------------------------------------------------------------------
PING túzfal beállítása GPO-val

https://thesysadminchannel.com/how-to-enable-ping-using-group-policy-gpo/


--------------------------------------------------------------------------------------------------------------
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


#Active Directory adatok lekérdezése
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

