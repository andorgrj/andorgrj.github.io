ping testlab.local

dcdiag 
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

#AD Replication
repadmin /showrepl
repadmin /showrepl /errorsonly
repadmin /replsummary
repadmin /showconn

Get-ADReplicationSite -Filter *
Get-ADDomainController -Filter * | ft Hostname,Site