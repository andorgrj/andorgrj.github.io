Add-AzureRmAccount
Get-AzureRmSubscription
Set-AzureRmContext -SubscriptionId "Tenant ID"

$rg2=New-AzureRmResourceGroup -name 'Project2' -Location 'West US'



Login
Bash környezetben
az login

Powersherll környezetben
az login --use-device-code


Hasznos infok
AZ help
az
az version



Default értékek megadása
az configure --defaults location=northeurope
az config get



Régiók listája

#bash
az account list-locations # Komplett lista
az account list-locations |grep name |grep europe # EU-ra szűrve
#ps
az account list-locations |Select-String name |Select-String europe



AZ objektumok létrehozása
Resource group
Létrehozás
az group create --name cliresourcegroup

az configure --defaults group=cliresourcegroup # belállítjuk default-nak

az config get
Lista
az group list



Virtual network Létrehozás

az network vnet create --name vnet-EUN `
--address-prefix 172.16.0.0/16 `
--subnet-name subnet-eun-01 `
--subnet-prefix 172.16.1.0/24


Lista
az network vnet list
az network vnet subnet list --vnet-name vnet-EUN


Másik subnet készítése meglévő vnet-be
az network vnet subnet create --vnet-name vnet-EUN -n subnet-eun-02 `
--address-prefix 172.16.2.0/24



Network Securty Group (tűzfal)
Létrehozás
az network nsg create --name clinsg




Új szabály létrehozása meglévő NSG-be
az network nsg rule create --name enable_http `
--nsg-name clinsg `
--priority 300 `
--direction Inbound `
--access Allow `
--destination-port-ranges 80 8080 `
--protocol Tcp `
--description "allow inbound HTTP traffic"
az network nsg rule create --name disable_https `
--nsg-name clinsg `
--priority 310 `
--direction Inbound `
--access Deny `
--destination-port-ranges 443 `
--protocol Tcp `
--description "deny inbound HTTPS traffic"
NSG hozzáadása egy subnet-hez
az network vnet subnet update --name subnet-eun-02 `
--vnet-name vnet-EUN `
--network-security-group clinsg


NSG listája
az network nsg rule list --nsg-name clinsg


Szabály törlése
az network nsg rule delete --nsg-name clinsg --name enable_http




Availability set
az vm availability-set create --name cliavset `
--platform-fault-domain-count 3 `
--platform-update-domain-count 3

# Ha meglévő Availability set-be szeretnénk ültetni a létrehozandó VM-et, akkor ez a sor fog kelleni:
# az vm create [..] --availability-set




VM
Image lista források:
https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/

az vm image list -p canonical -o table --all | grep 20_04-lts | grep -v gen2 |tail -1
# Vagy a mindenkori legújabb 20.04-LTS image:
# Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest




Létrehozás


az vm create --name cli-vm `
--image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest `
--size Standard_B1s `
--authentication-type password `
--admin-username linuxadmin `
--admin-password linuxadmin.12345 `
--nsg-rule SSH `
--storage-sku StandardSSD_LRS `
--vnet-name vnet-EUN `
--subnet subnet-eun-01 `
--public-ip-address cli-vm-publicip `
--public-ip-sku Basic `
--public-ip-address-allocation dynamic `
--nic-delete-option Delete `
--os-disk-delete-option Delete




Négy VM létrehozása:


foreach ($i in 1..4 ) { `
Start-Job { param ($j) `
az vm create --name cli-$j `
--image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest `
--size Standard_B1s `
--availability-set cliavset `
--authentication-type password `
--admin-username linuxadmin `
--admin-password linuxadmin.12345 `
--nsg-rule SSH `
--storage-sku StandardSSD_LRS `
--vnet-name vnet-EUN `
--subnet subnet-eun-01 `
--public-ip-address cli-$j-publicip `
--public-ip-sku Basic `
--public-ip-address-allocation dynamic `
--nic-delete-option Delete `
--os-disk-delete-option Delete `
 } -ArgumentList ($i) `
}




Load Balancer



# Load balancer
az network lb create --name cliloadbalancer `
--sku Standard `
--frontend-ip-name lbfrontendip `
--public-ip-address lbpublicip `
--public-ip-dns-name dharycliloadbalancer

# Backend pool
## Load balancer létrehozáskor automatikusan generálódik egy backend pool
## Meglévő backend pool nevének kiderítése:
az network lb address-pool list --lb-name cliloadbalancer

az network lb address-pool update --name cliloadbalancerbepool `
--lb-name cliloadbalancer `
--vnet vnet-EUN `
--backend-address name=addr1 ip-address=172.16.1.4 `
--backend-address name=addr2 ip-address=172.16.1.5 `
--backend-address name=addr3 ip-address=172.16.1.6 `
--backend-address name=addr4 ip-address=172.16.1.7

## Új backend pool létrehozása
az network lb address-pool create --name masikclipool `
--lb-name cliloadbalancer `
--vnet vnet-EUN `
--backend-address name=addr1 ip-address=172.16.1.4 `
--backend-address name=addr2 ip-address=172.16.1.5 `
--backend-address name=addr3 ip-address=172.16.1.6 `
--backend-address name=addr4 ip-address=172.16.1.7

# Healt probe
az network lb probe create --name clihealthprobe `
--lb-name cliloadbalancer `
--port 22 `
--protocol Tcp `
--interval 7 `
--threshold 3

# Load balance rule
az network lb rule create --name clibalancerule `
--lb-name cliloadbalancer `
--frontend-port 22 `
--backend-port 22 `
--protocol Tcp `
--backend-pool-name cliloadbalancerbepool `
--frontend-ip-name lbfrontendip `
--probe-name clihealthprobe




Storage Account
az storage account create --name dharyclistorageaccount `
--access-tier Hot `
--sku Standard_LRS `
--tags created-by=cli


### File share
az storage share create --name clifileshare `
--account-name dharyclistorageaccount

### Container
az storage container create --name clicontainer `
--account-name dharyclistorageaccount `
--public-access off



MySQL server

az mysql server create --name dharyclimysqlserver `
--admin-user david `
--admin-password "pKMxBT#y938?MB" `
--ssl-enforcement Disabled `
--version 8.0 `
--sku-name B_Gen5_1 `
--storage-size 5120 `
--auto-grow Disabled `
--backup-retention 7

### Tűzfal szabály hozzáadás
az mysql server firewall-rule create --name mindenki `
--server-name dharyclimysqlserver `
--start-ip-address 0.0.0.0 `
--end-ip-address 255.255.255.255