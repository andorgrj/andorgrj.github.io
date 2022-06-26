parancssoros könvtár csatlakozatatás
net use k: \\FS1\Shares

ugyanez powershellből
New-PSDrive -Name "S" -PSProvider FileSystem -Root \\SPS\Shares -Persist
New-PSDrive -Name "SShare" -PSProvider FileSystem -Root \\SPS\Shares

-Persist - file rendszerben is látszik
Csak A-Z betüjellel csatlakoztatható

Share eltávolítása
Remove-PSDrive -Name "S" -Force

Aktuálisan könyvtárstruktúrában elérhető meghajtók (Hierarchikus)
Get-PSDrive

Felhasználók Home könyvtárának csatlakoztatása
Windows Server – Setup Home Folders and Profile Folders
1. Könytárak kialakítás
2. SMB Share létrehozás New-SmbShare -path "C:\Shares" -Name "Shares" -FullAccess Everyone
3. Jogosultságok megadása NTFS szinten
4. AD-ben a userek kezelésénél a megfelelő beállítok a linkben szereplő képek alapján. Akár az összesre egyszerre a megfeleő útvonallal \\FS1\Shares\Users\%Username%

Quota kezelés
FileServerResourceManager

Quota kezelés Powershellből
Windows szerepkörök telepítése és lekérdezése parancssorból
Get-WindowsFeature -Name FS-Resource-Manager, RSAT-FSRM-Mgmt
Install-WindowsFeature -Name FS-Resource-Manager, RSAT-FSRM-Mgmt


Get-FsrmQuota
Get-FsrmQuotaTemplate
New-FsrmQuota -Path "C:\Shares" -Description "limit usage to 1 GB." -Size 1GB
Régi parancssoros lekérdezés
dirquota quota list
dirquota template list