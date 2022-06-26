#!/bin/bash

echo 'give in the suitable word'
read string
#string="snakes"
final=${string//[s]/v}
echo $final > $(date +%Y%m%d)

-----------------------------------------------------------------

# troubleshooting network connection 

#ip link show # on all device
#ip help

#nmcli device status  #gen network settings
#nmcli connection edit

#nslookup #dns resolve check

#ss # local  - port check 
#ss -t # TCP connection
#ss -l # listing the open ports
#ss -lt # lists all TCP ports

#tracepath # tracert between hosts

#nmap -O <IP> # nemtwork infos

#firewalld

---------------------------------------------------------

#set up a network bridge

#ip add                  #note the ethernet interface name
#nmcli conn show --active
#nmcli conn add type bridge con-name <new connection name> ifname <new connection name>   #creating a network bridge interface using the following nmcli command

#nmcli conn modify br0 ipv4.addresses '192.168.1.1/24'   #set IPv4 address, network mask, default gateway, and DNS server
#nmcli conn modify br0 ipv4.gateway '192.168.1.1'
#nmcli conn modify br0 ipv4.dns '192.168.1.1'
#nmcli conn modify br0 ipv4.method manual

#nmcli conn add type ethernet slave-type bridge con-name bridge-<new connection name> ifname <ethernet interface name> master <new connection name> #adding ethernet interface to the bridge

#nmcli conn up <new connection name>  #activate the bridge connection

#nmcli conn down Wired\ connection\ 1 #set down the wired connection

#nmcli conn show  --active   #checking if the fresh bridge is active

#bridge link show #showing the current bridge configuration details 

#nmcli conn down <new/created connection name> #to delete the bridge

--------------------------------------------------------------