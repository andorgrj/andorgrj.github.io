Clear-Host

Write-Host "*************************************************************************************" 
     

Write-Host "Simple Report"


Get-Date


$info = Get-ComputerInfo

write-Host "A számítógép neve:" ($info).CsName




Get-LocalUser | Select-Object Name,Lastlogon | Format-List



$net = Get-NetIPAddress

$net | Where-Object -Property PrefixOrigin -eq DHCP | Format-Table



#vagy a Net-Adapter segítségével




Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 5 


Write-Host "End riport"
Write-Host "************************************************************************************"