
$path = "OU=PeldaUsers, DC=testlab,DC=local"

Get-ADOrganizationalUnit -Identity "OU=PeldaUsers, DC=testlab,DC=local"

Get-ADOrganizationalUnit $path  | Select-Object *

# Rekurzív keresés - subtree keresés
Get-ADOrganizationalUnit -SearchBase $path -SearchScope Subtree -Filter * | Select-Object DistinguishedName, Name

# Új OU 
$path = "OU=PeldaUsers, DC=testlab,DC=local"
New-ADOrganizationalUnit -Name "Gyártás" -Path "OU=PeldaUsers, DC=testlab,DC=local"
$path = "OU=Gyártás,"+ $path
New-ADOrganizationalUnit -Name "Tervezés" -Path $path
New-ADOrganizationalUnit -Name "Gyártás" -Path $path
New-ADOrganizationalUnit -Name "Logisztika" -Path $path
$path = "OU=Logisztika,"+ $path
New-ADOrganizationalUnit -Name "Raktározás" -Path $path
New-ADOrganizationalUnit -Name "Szállítmányozás" -Path $path

# Törél engedélyezés
Set-ADOrganizationalUnit $path -ProtectedFromAccidentalDeletion $False
Remove-ADOrganizationalUnit $path

function Get-CanonicalName ([string[]]$DistinguishedName) {    
    foreach ($dn in $DistinguishedName) {      
        $d = $dn.Split(',') ## Split the dn string up into it's constituent parts 
        $arr = (@(($d | Where-Object { $_ -notmatch 'DC=' }) | ForEach-Object { $_.Substring(3) }))  ## get parts excluding the parts relevant to the FQDN and trim off the dn syntax 
        [array]::Reverse($arr)  ## Flip the order of the array. 
 
        ## Create and return the string representation in canonical name format of the supplied DN 
        "{0}/{1}" -f  (($d | Where-Object { $_ -match 'dc=' } | ForEach-Object { $_.Replace('DC=','') }) -join '.'), ($arr -join '/') 
    } 
}

$path = "OU=Peldaceg,DC=testlab,DC=local"

Get-CanonicalName $path

$OUs = (Get-ADOrganizationalUnit -SearchBase $path -SearchScope Subtree -Filter '*').DistinguishedName
Get-CanonicalName $OUs