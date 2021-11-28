https://blog.netwrix.com/2018/04/18/how-to-manage-file-system-acls-with-powershell-scripts/
https://blog.netwrix.com/2018/04/18/how-to-manage-file-system-acls-with-powershell-scripts/
https://hu.abcdef.wiki/wiki/Role-based_access_control
https://kepzes.progmasters.hu/pluginfile.php/23129/mod_resource/content/1/F%C3%A1jlkiszolg%C3%A1l%C3%B3.pdf


fájljogosultságok powershellel cikkek
---------------------------------------------------------------------------------------------------------------
Öröklődés kikapcsolása

Kiválasztott mappára properties -> Security -> Advanced -> inheritance -> explicit -> edit -> details

---------------------------------------------------------------------------------------------------------------
Share cuccok megtekintése

\\gandorWS2019\c$
vagy
Start menü jobb gomb -> Computer Management -> Shared folders
vagy
Active Directory Users and Computers -> File and Storage Services -> Shares

----------------------------------------------------------------------------------------------------------------
Share készítése

Mappa készítése -> Properties -> Share -> Advanced Sharing -> Permissions -> everyonet törölni -> authenticated usereket helyébe





----------------------------------------------------------------------------------------------------------------

Sharing Stop

Active Directory Users and Computers -> File and Storage Services -> Shares -> jobb egér -> Stop sharing

Jogosultsággal nem rendelkező mappa elrejtése a felhasználó elől:

mappa nevén jobb egér -> Properties -> Settings -> Enable access based enumeration

---------------------------------------------------------------------------------------------------------------
<#
Remember, you have two types of permission with shares

1) Share Permissions - What users can do with the share itself
2) Folder Permissions - What users can do with the folder being shared, 
    and any files/folders contained within the shared folder
#>

# -------------------------------------------------------------------------------------
# Share jogosultságokkal megosztunk
Get-Command -Module smbshare

New-SmbShare -Name "Peldashare" -Path "C:\Peldashare"

Get-SmbShare -Name "Peldashare"
Get-SmbShareAccess -Name "Peldashare"

Grant-SmbShareAccess -Name peldashare -AccountName ujcsoport1 -AccessRight Custom
Revoke-SmbShareAccess -Name peldashare -AccountName ujcsoport1
Block-SmbShareAccess -Name peldashare -AccountName mentor3 -Force
Unblock-SmbShareAccess -Name peldashare -AccountName mentor3 -Force

# ---------------------------------------------------------------------------------------
# NTFS jogosultságok kezelés Acl objektumokkal történik /finomhangolunk
# Acl (Access Controll List), ACE (Access Controll Entities)
Get-acl | Select-Object *
$egyacl = Get-acl
($egyacl).Access

Get-Acl | Get-Member

# Új könyvtár és hozzá 1 usernek full controll adása NTFS jogosultságként
New-Item -Type Directory -Path "C:\Peldashare"
$Acl = Get-Acl . # Acl objektum
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("Mentor5", "FullControl", "Allow") # Acl rule objektum (ACE)
$Acl.SetAccessRule($Ar) # Beállítjuk az új objektumot 
Set-Acl -Path "C:\Peldashare" -AclObject $Acl # Visszaírjuk a változást az eredeti Acl objektumba
$Acl | Set-Acl -Path "C:\Peldashare" # Ugyanaz pipe-al

# Több usernek 
$users = 'foo', 'bar', 'baz'
foreach ($user in $users) {
    $ace = New-Object Security.AccessControl.FileSystemAccessRule ("Desktop\${user}", 'Read', 'Allow')
    $acl.AddAccessRule($ace)
}
# $acl | Set-Acl -path "c:\utvonal"
# .SetAccessRule will overwrite any existing acls (other than inherited rights) while .AddAccessRule will leave existing acls unchanged.