script futtatáshoz chmod 744 szükséges

--------------------------------------------------------------------
Beépített változók
#!/bin/bash

echo $1

i=1
echo $i

i='Hello World'
echo $i

i=$(ls -lah)
echo $i



--------------------------------------------------------------------
WHILE

#!/bin/bash

echo 'meddig számoljak'
read szam

i=1

while [ $i -lt $szam ]
do
echo $i
i=$((i+1))
done

--------------------------------------------------------------------
IF

#!/bin/bash

echo 'add meg az első számot'
read elso
echo 'add meg a második számot'
read masodik

if [ $elso -gt $masodik ]
then
echo 'Az első szám nagyobb'
exit 0

elif [ $elso -lt $masodik ]
then
echo 'Az első szám kisebb'
exit 0

else 
echo 'a két szám egyenlő'
exit 0

fi
exit 0

-------------------------------------------------------------------
CASE - felsorolás szerű, hogy milyen esetekben (itt pl kis és nagybetűk esetében)

#!/bin/bash

echo "[O]vas"
echo "[H]ozzáfűz"
echo "[S]zerkeszt"

read menupont 

case "$menupont" in 
 "O" | "o")
echo "Olvasási műveletek"
;;

"H" | "h")
echo "Hozzáfűzési műveletek"
 ;;

"S" | "s" )
echo "Szerkesztési műveletek"
;;
esac

----------------------------------------------------------------
Feladat - a megadott echok alapján végez műveletet
#!/bin/bash

echo "[O]vas"
echo "[H]ozzáfűz"
echo "[S]zerkeszt"

read menupont 

case "$menupont" in 
 "O" | "o")
echo "Olvasási műveletek"
cat pelda.txt
;;

"H" | "h")
echo "Hozzáfűzési műveletek"
echo "Mit fűzzek hozzá? "
read app
echo ${app} >> pelda.txt
 ;;

"S" | "s" )
echo "Szerkesztési műveletek"
nano pelda.txt
;;
esac

-------------------------------------------------------------------
Felhasznaló létrehozás

#!/bin/bash

echo 'Felhasznalo nev'
read name
echo 'Homekonyvtar neve'
read homedir
#echo 'Jelszo' -> jelszó nem marad titkosítva
#read pw
sudo useradd -m -d /home/${homedir} -p ${pw} ${name}
sudo passwd $username 


#a=$(pwd)
#echo $a

#a=`pwd`
#echo $a

--------------------------------------------------------------------
Manage computer

#!/bin/bash

# Excercise 1 - Print actual date
echo -e "\n--- Current date ---------------------------"
echo -e $(date +"%F")

# Excercise 2 - Print host name
echo "\n--- Hostname -------------------------------"
hostname

# Excercise 3 - Print IP address of any network interface
echo "--- Default NIC IPv4 address ---------------"
sudo ifconfig $(ip -o -4 route show to default | awk '{print $5}') | grep 'inet'

# Excercise 4 - Print available storage spaces / memory
echo "\n--- Storage and memory info ----------------"
sudo df -h
sudo free -h

# Excercise 5 - Print CPU type
echo "\n--- CPU model ------------------------------"
sudo cat /proc/cpuinfo | grep 'model name' | head -1 | cut -d':' -f 2

# Excercise 6 - Print syslog last 5 lines
echo "\n--- Last 5 system event --------------------"
sudo cat /var/log/syslog | tail -5

# Excercise 7 - Print last 10 logins in descending time order
echo "\n--- Last 10 logons -------------------------"
sudo last -a | head -10

# Excercise 8 - Print currently logged in users
echo "\n--- Currently logged in users --------------"
sudo users


--------------------------------------------------------------------
Fizzbuzz

#!/bin/sh

i=1
while [ $i -lt 101 ]
do

  TEXT=""
  if [ $(($i%3)) = "0" ]
  then
    TEXT="Fizz"
  fi

  if [ $(($i%5)) = "0" ]
  then
    TEXT=$TEXT"Buzz"
  fi

  if [ "$TEXT" != "" ]
  then
    echo $i": "$TEXT
  fi
  i=$(( $i + 1 ))
done


--------------------------------------------------------------------
Manage-users scriptek


# Excercise 1 - Create directory structure
sudo mkdir -p /etc/custom-skel/finance
sudo mkdir -p /etc/custom-skel/hr
sudo mkdir -p /etc/custom-skel/dev

# Excercise 2a - Create "Welcome.txt" in department folder
echo "Welcome to finance department!" > /etc/custom-skel/finance

# Excercise 2b - Create "Welcome.txt" in department folder
echo "Welcome to HR department!" > /etc/custom-skel/hr

# Excercise 2c - Create "Welcome.txt" in department folder
echo "Welcome to dev department!" > /etc/custom-skel/dev

# Excercise 3 - Create 3 user groups
sudo groupadd finance
sudo groupadd hr
sudo groupadd dev

# Excercise 4 - Create users
sudo useradd --password D3v01 --gid dev --create-home --skel /etc/custom-skel/dev dev1
sudo useradd --password D3v01 --gid dev --create-home --skel /etc/custom-skel/dev dev2
sudo useradd --password F1N01 --gid finance --create-home --skel /etc/custom-skel/finance fin1
sudo useradd --password HR123 --gid hr --create-home --skel /etc/custom-skel/hr hr1

# Excercise 5 - Add dev users to sudo group
usermod -aG sudo dev1
usermod -aG sudo dev2


---------------------

for grp in szerelok beszerzes management;
do
  sudo groupadd --force --system $grp
  for usr in 1 2 3
  do
    sudo useradd --comment $grp$usr --home-dir /home/$grp/$grp$usr --create-home $grp$usr
  done;
done;

sudo apt-get update && sudo apt-get install acl -y

sudo mkdir -p /home/szerelok/szerszam && sudo setfacl-Rdm u::-,group:szerelok:rw,group:management:rw,o::- /home/szerelok/szerszam
sudo mkdir -p /home/beszerzes && sudo setfacl -Rdm u::-,group:beszerzes:rw,group:management:rw,o::- /home/szerelok/szerszam
sudo mkdir -p /home/management && sudo chown :management /home/management && setfacl -Rdm u::-,group:beszerzes:rw,group:management:rw,o::- /home/management

---------------------

#!/bin/bash

# Excercise 1/2 - Create directory structure, create Welcome.txt
for dept in {finance,hr,dev}
do
  sudo mkdir -p /etc/custom-skel/${dept}

  if [ "$dept" = "hr" ]; then
    echo "Welcome to ${dept^^} department!" > /etc/custom-skel/${dept}/"Welcome.txt"
  else
    echo "Welcome to ${dept} department!" > /etc/custom-skel/${dept}/"Welcome.txt"
  fi
  chmod 644 /etc/custom-skel/${dept}/"Welcome.txt"
done

# Excercise 3 - Create usergroups
for d in {finance,hr,dev}
do
  sudo groupadd ${d}
done

# Excercise 4 - Create users 

# Same array index reprezents one user's data. 
USERNAMES=("dev1" "dev2" "fin1" "hr1")
USERPWDS=("D3v01" "D3v01" "F1N01" "HR123")
USERGRPS=("dev" "dev" "finance" "hr")
SKELDIRS=("/etc/skel/dev" "/etc/skel/dev" "/etc/skel/dev" "/etc/skel/hr")

ALEN=${#USERNAMES[@]}

# Iterate through the data arrays and create user according to arrays indexes
for (( i=0; i < $ALEN; i++ ))
do
  sudo useradd --password ${USERPWDS[$i]} --gid ${USERGRPS[$i]} --create-home --skel ${SKELDIRS[$i]} ${USERNAMES[$i]}

  # Excercise 5 - Add dev users to sudo group
  if [[ ${USERNAMES[$i]} == dev* ]]; then
    usermod -aG sudo ${USERNAMES[$i]}
  fi
done


-----------------------------------------------------------------------------------------

mkdir –p szerelok/szerszam
mkdir beszerzes
mkdir management

groupadd szerelok
groupadd beszerzes
groupadd management

gpasswd -M szerelouser1,szerelouser2,szerelouser1 szerelok

useradd -md - m létrehoza a home könyvtárat, -d kijelöli

sudo adduser szerelouser1 --gecos --disabled-password
echo "myuser:password" | sudo chpasswd
sudo adduser szerelouser2 --gecos --disabled-password
echo "myuser:password" | sudo chpasswd
sudo adduser szerelouser3 --gecos --disabled-password
echo "myuser:password" | sudo chpasswd



--------------------------------------------------------------------
Mentett állományok vizsgálata /find.sh -> jogosultságra és méretre szűr és a megadott névvel és helyre menti eredményt

#!/bin/bash
datum=$(date -I)
filename=”jog$datum”
sudo find /home/perm 744 >> /home/andor/files/$filename
filename=”meret$datum”
sudo find /home/ -type file f -size +100c >/home/../files/$filename  #->100 bájtnál nagyobb fájlokat hozza ki
echo “kész”


--------------------------------------------------------------------
FIND

-perm jogosultságokra szűrés
-name fájl/mappanévre szűrés 
-type típusra szűrés például f fájl
-size méretre szűrés:

https://linuxconfig.org/how-to-use-find-command-to-search-for-files-based-on-file-size



---------------------------------------------------------------------
echo ""


if [ $menupont = "O" ]
then
echo "Olvasási művelet"
cat pelda.txt
exit 0

elif [ $menupont = "H" ]
then
echo "Hozzáfűzési műveletek"
echo "Mit?"
read app
echo ${app} >> pelda.txt
exit 0
