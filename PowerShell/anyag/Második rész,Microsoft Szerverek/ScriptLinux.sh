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
Mentett állományok vizsgálata /find.sh -> jogosultságra és méretre szűr és a megadott névvel és helyre menti eredményt

#!/bin/bash
datum=$(date -I)
filename=”jog$datum”
sudo find /home/perm 744 >> /home/andor/files/$filename
filename=”meret$datum”
sudo find /home/ -type file f -size +100c >/home/../files/$filename  #->100 bájtnál nagyobb fájlokat hozza ki
echo “kész”


--------------------------------------------------------------------
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
