AD telepítés
windows srv 2019 (gandorWS2019 -re)


Server Manager -> Add Roles and Features -> Add -> Active Directory DOMAIN SERVICES
    1)Post deployment configuration
    2)Promote this server to a domain controller
    3)Add a new forest -> root domain name: gandor.local
https://e-learning.training360.com/courses/take/active-directory-2019/lessons/14503758-domain-controller-telepitesenek-elokeszitese
    4)netbios név ugyanaz legyen mint a domain név(gandor.local)

-------------------------------------
- GC Global Catalog
- DNS
- feature: group policy management (csoport házi rend kezelő)

Promotálni kell a gépet domain controllernek

ki kell választani, hogy uj domain, vagy egy másik domain tagja
új erdó (forest) 
domain név : testlab.local v. testlab.hu (???)
dc verzió: ws2016 - amennyiben másik régebbi forestbe kapcsolódunk ahhoz kell állítani
DNS és GC(global catalog) kipipálva, hozza létre
Dc alapkönytárai (default)
DSRM - domain adatbázis jelszava (ha különbözik ird fel!)
netbiosnév ugyanaz legyen mint a domain név (.local nélkül)

Telepítőtől visszakapott script: (powershellből létrehozná ugyanazt a domaint amit beállítottam)
#
# Windows PowerShell script for AD DS Deployment
#

Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "testlab.local" `
-DomainNetbiosName "TESTLAB" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true
-------------------------------------
Létrehoztuk, ezután


DNS -> start menübe írva
forwarder, müködő DNS cimmel
FQDN name -> gandorWS2019.gandor.local
gandorWS2019 DNS -> jobb egér -> properties -> DNS forwarders (itt lehet beállítani a dns servereket pl.8.8.8.8de van benne egy alapértelmezett már)
dns-t állítok be akkor az a localhost lesz
Miket hozott létre?
AD Users and Computers
AD Domains and Trusts -> domainek között lehet trusted kapcsolatot létrehozni

        A modul automatikusan beimportálódik, de ha nem akkor a következő módon lehet hozzáadni
            Get-Module
            Get-Module -ListAvailable
            Import-Module ActiveDirectory
            Get-Module
            Get-ADDomain -> domain paramétereinek lekérdezése
            Remove-Module ActiveDirectory
        Domain admin csoportban vagyok, erdőhöz Enterprise Adminban

Saját OU-k létrehozása a domainen belül (computers,groups, users) 
Utána user létrehozása ou-ban -> new user -> Get-ADUser -> lekérdezés
Usernél logon scriptet lehet beállítani
View - advanced features

-----------------------------------------------------------------------------------------------------------------------------------------
Gép behúzása Domainba

DNS servert kell beállítani: ncpa.cpl -> properties -> IPV4 -> DNS server megadása (ebben az esetben a servert húzom be ide 10.0.0.6)
This PC -> Properties -> Change settings -> Computer Name -> Change -> Member of a Domain -> gandor.local állítom be

------------------------------------------------------------------------------------------------------------------------------------------
PS parancsok

Get-Module
Get-Module -ListAvailable
Import-Module ActiveDirectory
Get-Module
Get-ADDomain
Remove-Module ActiveDirectory

Get-ADOrganizationalUnit

Get-ADUser 
Get-ADUser | Where-Object {$_.SamAccountName -eq "nagy.jozsef"}
$jozsi = Get-ADUser | Where-Object {$_.SamAccountName -eq "nagy.jozsef"}
$jozsi | Get-Member

Get-ADGroup

-------------------------------------------------------------------------------------------------------------------------------------------

DHCP role telepítés
Scope
terjesztésből kizárt tartományt
reservation - mac address alapján kiosztott IP cím
DNS, Default gateway

---------------------------------------------------------------------------------------------------------------------------------------------

https://social.technet.microsoft.com/wiki/contents/articles/16757.active-directory-glossary.aspx
https://hu.wikipedia.org/wiki/Active_Directory
https://hu.wikipedia.org/wiki/Flexible_single_master_operation