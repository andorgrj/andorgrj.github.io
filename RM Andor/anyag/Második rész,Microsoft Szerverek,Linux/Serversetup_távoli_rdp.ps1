TrustedHost megadása a kapcsolódáshoz

Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force  -> * helyett ip cím is megadható
Get-Item WSMan:\localhost\Client\TrustedHosts


------------------------------------------------------------------------------------------------------------------------------------
Remote Session / PSSession / Windows Remote Management


$username = "gandor"
$password = ConvertTo-SecureString "Password123!" -AsPlainText -Force
$gandorscred = New-Object System.Management.Automation.PSCredential ($username, $password)

New-PSSession -ComputerName 10.0.0.5 -Credential $gandorscred  -> belső ip címet kell megadni
Get-PSSession
Enter-PSSession 1 -> PSSession-be itt tudok belemenni (jelen esetben a core gépbe)

------------------------------------------------------------------------------------------------------------------------------------
Azon a gépen amelyiket kezelni akarod:

Ellenőrizni, hogy a WinRM szolgáltatás fut: 
Get-Service winrm
Get-WmiObject -Class win32_service | Where-Object {$_.name -like "WinRM"}
Set-Service WinRM -StartMode Automatic

Engedélyezni a PSRemote-ot:
Enable-PSRemoting -Force vagy 
Enable-PSRemoting -Force ‑SkipNetworkProfileCheck

https://www.netspi.com/blog/technical/network-penetration-testing/powershell-remoting-cheatsheet/

------------------------------------------------------------------------------------------------------------------------------------
The Invoke-Command cmdlet runs commands on a local or remote computer and returns all output from the commands, including errors. Using a single Invoke-Command command, you can run commands on multiple computers.


Invoke-Command -ScriptBlock {$env:COMPUTERNAME} -ComputerName 10.0.0.5
Invoke-Command -ScriptBlock {D:\ps.ps1} -ComputerName 10.0.0.5

---------------------------------------------------------------------------------------------------------------------------------
Sysinternals - A Windows Sysinternals egy olyan webhely, amely technikai erőforrásokat és segédprogramokat kínál a Microsoft Windows környezet kezeléséhez, diagnosztizálásához, hibaelhárításához és megfigyeléséhez.

BGInfo -> show server information 

https://docs.microsoft.com/en-us/sysinternals/downloads/bginfo

https://docs.microsoft.com/en-us/sysinternals/


---------------------------------------------------------------------------------------------------------------------------------
Sources and guides from the internet for REMOTE CONTROLLING

https://docs.microsoft.com/hu-hu/powershell/scripting/learn/remoting/running-remote-commands?view=powershell-5.1

https://virtuallyinclined.com/2017/06/01/windows-server-2016-active-directory-setup-part-1/  -> wm beállítása alapok

https://www.netspi.com/blog/technical/network-penetration-testing/powershell-remoting-cheatsheet/

https://sid-500.com/2017/07/09/powershell-remoting-how-to-connect-to-remote-hosts-in-a-domain-and-in-a-non-domain-environment-trusted-hosts/

Invoke-kal távoli gépet lehet
---------------------------------------------------------------------------------------------------------------------------------



mstsc.clp -> távoli asztali kapcsolat
All Servers/ Performance Counter -> Start Performance Counter
ncpa.cpl -> hálózati beállítások
All Servers/ Roles and Features -> Manage -> Add Roles -> IIS WebServer -> Get-WindowsFeature -> Gets information about Windows Server roles, role services, and features that are available for installation and installed on a specified server.
        https://docs.microsoft.com/en-us/powershell/module/servermanager/get-windowsfeature?view=winserver2012r2-ps
Port -> .nsg-ben/Network Security Group -> Bejövő biztonsági szabályok -> 80-as portot be kell állítani, ahhoz, hogy kivülről látható legyen
Ping -> engedélyezése -> .nsg-ben -> Inbound Security Rules -> Add ICMP
Firewall -> advanced settings -> Inbound Rules -> Virtual Machine Monitoring IPV4/6 and File and Printer Sharing (Echo Request –ICMPv4-In -> Set Enable
        https://www.rootusers.com/how-to-enable-ping-in-windows-server-2019-firewall/
WebServer tartalmának módosítása -> IIS -> Server\Sites\Default Sites\Explore\  ->  ThisPC\Windows\inetpub\wwwroot -> html fájl jobbegér open with/szerkesztés notepadban és ide lehet berakni a kódot
CTRL+ALT+End -> Task Manager

----------------------------------------
CORE beállítások
sconfig 7/e/2 ; 10/2 ; 4/1/3
core.nsg -> ping -> ICMP set
TrustedHosts beállítása


------------------------------------------------------------------------------------------------------------------------------------------------
Távoli asztali csatlakozás engedélyezése / mstsc

Open this in the workstation where you want to connect, Control Panel\System and Security\System, click Advance System Settings. On the Remote tab, on the Remote Desktop group, click the button Select Users...

Click Add and add the user that you want to have access. If you are using AD, make sure you can ping the domain. Always click Check Names, to make sure that the user you are adding are correct. ex: myusername@mydomain.com.


---------------------------------------------------------------------------------------------------------------------------------------------------




Azon a gépen amelyiket kezelni akarod:

Ellenőrizni, hogy a WinRM szolgáltatás fut:  Get-Service WinRM vagy részletesebben: Get-WmiObject -Class win32_service | Where-Object {$_.name -like "WinRM"} , ha nem, akkor el kell indítani: Set-Service WinRM -StartMode Automatic
Engedélyezni a PSRemote-ot Enable-PSRemoting -Force vagy Enable-PSRemoting -Force ‑SkipNetworkProfileCheck If the computer's current connection type is set to public, the above command will produce an error message because by default PowerShell remoting is only enabled for private and domain connection types. To avoid the error message and enable PowerShell remoting on a public network, you can use the ‑SkipNetworkProfileCheck parameter.

Azon a gépen amelyikről kezeled:

Felvenni a hostot a megbízható hostok közé Set-Item WSMan:\localhost\Client\TrustedHosts -Value "10.0.2.33" -Force vagy engedélyezni mindent Set-Item WSMan:localhost\client\trustedhosts -value * Trusted hostok ellenőrzése Get-Item WSMan:\localhost\Client\TrustedHosts
PSSession létrehozása $valtozo = New-PSSession –ComputerName xxxx –Credentials domain\serveradmin vagy csak simán New-PSSession –ComputerName xxxx –Credentials domain\serveradmin
Belépés 1 PSSessionbe Enter-PSSession –ComputerName xxxx –Credentials domain\serveradmin vagy ha van háttérkapcsolat akkor Enter-PSSession $valtozo

https://4sysops.com/wiki/enable-powershell-remoting/