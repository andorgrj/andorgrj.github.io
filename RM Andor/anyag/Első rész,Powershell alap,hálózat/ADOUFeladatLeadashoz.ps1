<#Script a leadáshoz

1. Futasd le a function részt külön
2. $path a Példacéged OU-inak rootja legyen
3. Az $outfile váltzónak is a nálad helyes utvonalat add meg. A text fájl neve a sorszámoddal kezdődjön.
#>

$path = "OU=Peldaceg,DC=testlab,DC=local"
$outfile = "C:\Peldashare\00HAOUs.txt"

$OUs = (Get-ADOrganizationalUnit -SearchBase $path -SearchScope Subtree -Filter '*').DistinguishedName
Get-CanonicalName $OUs | Out-File $outfile


function Get-CanonicalName ([string[]]$DistinguishedName) {    
    foreach ($dn in $DistinguishedName) {      
        $d = $dn.Split(',') ## Split the dn string up into it's constituent parts 
        $arr = (@(($d | Where-Object { $_ -notmatch 'DC=' }) | ForEach-Object { $_.Substring(3) }))  ## get parts excluding the parts relevant to the FQDN and trim off the dn syntax 
        [array]::Reverse($arr)  ## Flip the order of the array. 
 
        ## Create and return the string representation in canonical name format of the supplied DN 
        "{0}/{1}" -f  (($d | Where-Object { $_ -match 'dc=' } | ForEach-Object { $_.Replace('DC=','') }) -join '.'), ($arr -join '/') 
    } 
}