#!/bin/bash

mkdir -p /home/vizsga2022
cd ~
cd vizsga2022

groupadd vivok
groupadd uszok
groupadd birkozok

useradd fuchs_jeno -G vivok -p Passw0rd
useradd posta_sandor -G vivok -p Passw0rd
useradd piller_gyorgy -G vivok -p Passw0rd
useradd egerszegi_krisztina -G uszok -p Passw0rd
useradd darnyi_tamas -G uszok -p Passw0rd
useradd cseh_laszlo -G uszok -p Passw0rd
useradd varga_janos -G birkozok -p Passw0rd
useradd repka_attila -G birkozok -p Passw0rd
useradd farkas_peter -G birkozok -p Passw0rd

history -c

mkdir -p /vizsga2022/szakosztaly/vivas
mkdir -p /vizsga2022/szakosztaly/uszas
mkdir -p /vizsga2022/szakosztaly/birkozas

chown :vivok /vizsga2022/szakosztaly/vivas
chown :uszok /vizsga2022/szakosztaly/uszas
chown :birkozok /vizsga2022/szakosztaly/birkozas

chmod -R g=rw /vizsga2022/
chmod g=r /vizsga2022/szakosztaly/birkozas  "g=r Give the members of the group permission to read the file, but not to write and execute it: chmod g=r filename"

find /usr/lib -type f -size +10M

head -3 /etc/passwd
tail -2 /etc/passwd
cat etc/passwd | grep var

---------------------------------------------------------------------------------------------------------------------------

mkdir -p /home/vizsga2022_mon
cd /home/vizsga2022_mon

touch vizsga_monitor.txt
date=`date +%Y.%m.%d`
echo -e "***\n*\n* Nevem : Neved\n* Dátum : $date\n* Számítógépnév : $HOSTNAME \n* \n***" > vizsga_monitor.txt

nmcli | grep inet4 >> vizsga_monitor.txt

cat /etc/group >> vizsga_monitor.txt
cat /etc/passwd >> vizsga_monitor.txt


firewall-cmd --get-active-zones >> vizsga_monitor.txt
iptables --list >> vizsga_monitor.txt

cd ..
mkdir szoveg
cp /var/*.txt /home/szoveg

cd ..
mkdir web
cd web
touch main.html
echo "Záró vizsga" > main.html

rm -R /home/vizsga2022_mon

systemctl disable firewalld.service
systemctl stop firewalld.service 

--------------------------------------------------------------------------------------------------------------------------------
A feladat elkészítéséhez egyaránt használható Windowsos és Linuxos környezet.

A feladat, hogy hozz létre egy szkriptet, ami képes az alábbi feladatok elvégzésére. Feltételezhetjük, hogy a szkriptet adminisztrátori jogosultsággal futtatjuk, ezért erre nem kell külön figyelmet fordítani.

Beadandó fájl neve: user_vizsga.ps1 vagy user_vizsga.sh

Összesen elérhető: 20 pont

Hozd létre a vizsga2022 mappát. A fájlműveleteket a “vizsga2022” könyvtár tartalmával kell elvégezni

Elérési út Windowsos környezetben: C:\feladat\vizsga2022
Elérési út Linuxos környezetben: /home/vizsga2022
Feladatok:

3 pont - Hozzuk létre az alábbi lokális felhasználói csoportokat
vivok
uszok
birkozok
5 pont - Hozzuk létre az alábbi lokális felhasználókat

Felhasználónév: fuchs_jeno Jelszó: Passw0rd
Felhasználónév: posta_sandor Jelszó: Passw0rd
Felhasználónév: piller_gyorgy Jelszó: Passw0rd
Felhasználónév: egerszegi_krisztina Jelszó: Passw0rd
Felhasználónév: darnyi_tamas Jelszó: Passw0rd
Felhasználónév: cseh_laszlo Jelszó: Passw0rd
Felhasználónév: varga_janos Jelszó: Passw0rd
Felhasználónév: repka_attila Jelszó: Passw0rd
Felhasználónév: farkas_peter Jelszó: Passw0rd
4 pont - Rakjuk bele az alábbi csoportokba az alábbi felhasználókat

vivok
fuchs_jeno
posta_sandor
piller_gyorgy
uszok
egerszegi_krisztina
darnyi_tamas
cseh_laszlo
birkozok
varga_janos
repka_attila
farkas_peter
3pont - Hozzuk létre az alábbi könyvtárakat és állítsuk be az alábbi jogosultságokat, a megadott könyvtárakhoz, és azokban lévő összes fájlhoz

Teljes írás és olvasási jog az ‘vivok’ csoportnak (Linuxon legyen ő a tulajdonos csoport)
**\vizsga2022\szakosztalyok\vivas**
Teljes írás és olvasási jog az ‘uszok’ csoportnak (Linuxon legyen ő a tulajdonos csoport)
**\vizsga2022\szakosztalyok\uszas**
Olvasási jog az ‘birkozok’ csoportnak (Linuxon legyen ő a tulajdonos csoport)
**\vizsga2022\szakosztalyok\birkozas** (Powershell alatt smb és acl megoldás is elfogadható)

2 pont - Listázzuk ki azokat a fájlokat amik nagyobbak 10MB-nál az linux alatt /usr/lib könyvtárből windows alatt \System32\drivers\etc\hosts

3 pont - Írassuk ki a linux alatt a /etc/passwd windows alatt \System32\drivers\etc\hosts fájl

1pont - első 3 sorát
1pont - utolsó 2 sorát
1pont - azokat a sorokat amelyek tartalmazzák windows alatt a host linux alatt a var szót