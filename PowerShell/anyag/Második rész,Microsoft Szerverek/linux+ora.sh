ctrl + l  - törli a képernyőt
ctrl + r - historyban keres visszafelé


d - könyvtár
l - szimbolikus link
.. - szülő könyvtár
b - blokk eszköz
c - karaktertípus eszközök, valamilyen virtuális cucc 
ls -lh /dev 

mkfifo pipe
ls -lh pipe
tail -F pipe

while :; do date > pipe ; sleep ls > done &
jobs
fg
cat pipe
bg
cat pipe

kill %1 -utolsó jobot bezárja

rm -rf a* b* c*  - rm törlés haladó változat

rm -r  - remove rekurzívan, teljes mappát és almappát tartalommal törli

touch d/e - d-ben hozza az e-t létre
chmod -w d/e - writeot elvesszük tőle

rm -rf - force rekurzív eltávolítás

ls -lh /var/log
ls -lhS - méret szerint rendezi a fájlokat
ls -lht - t módosítás ideje szerint rendezi a fájlokat

másolás:
touch g 
ls -lh
cp g h
ls -lh
rm g h
cp -a - mindent másol rekurzívan

mv i n - átnevezés: iből n lett

mv j/k n/ - felülírja 

chgrp - csoportját tudom átállítani 
chown csoport:tulajdonos 
chown :tulajdonos - jogosultság állítás 

ls -lhd /tmp - -d kapcsoló a könytárat listázza nem a tartalmát

mkdir p
date > p/q
cat p/q
ls -lh
chmod -r - olvasás jogot veszem el
chmod +r - olvasás jogot adom hozzá
chmod u/user g/group o/others - jogokat lehet módosítani

umask - itt lehet állítani a létrejövő fájl jogosultságait

ls -lhR - teljes könyvtárstruktúrát mutatja
tree -h - ember által olvasható méret formában mutatja

find - könytárakat, fájlokat kiírja
find -type d - könyvtár típusú fájlokat listázza k
find -cmin +60 - legalább 60 perce módosított fájlokat írja ki
find -cmin -10
find /var/log -ctime -1 - elmúlt 1 napban módosult fájlokat írja ki
find /var/log -atime -1 - file access timeot írja ki
find /var/log -mmin -300 - módosult fájlok listája


find -user root - root userek megkeresése
find -group sudo
find -print
{} \; - összes fájlt jelenti tömeges módosításhoz

szimblikus linkek - nem lehet állítani a jogosultságát
touch y
ln -s y z
ls -lh
date y
cat y
cat z
date > z
cat z
cat y
ls -lh
rm y
ls -lh


date > a
ln a b
ls -s a aa
ln -s b bb
ls -lh
chmod -w b
ls -lh
chmod -w aa
ls -lh


history
!! - utoljára kiadott parancsot ismételi meg
!t:p - utolsó t vel kezdődő parancsot írja ki

echo $home
echo {HOME}1

date > e
cat e
1 - standard output
2 - standard error

ls -lh a ab


átirányításokat fordítva hajtja végre

ls -lh a ab ; echo hello - mindkét parancsot kiadja
|| vagy 
&& 


find > results
grep k results
grep -i k results
touch K
find -v K - -v-vel az olyat keresi amiben nincs "nagy K"
grep -r

head /etc/passwd
head -5
tail 
tail -5
tail -f /var/log/syslog - e mappa tartalmát folyamatossan kiírja
tail -F  - nagy f a fájlt határozza meg
less
cut

tar - tömörít
gzip - összetömörít és az eredetit törli
gunzip - kicsomagol

du - disk usage
du -shc *
du -shc /var/log/* | sort -hr - fájlok méretét adja meg 
ncdu - érdemes telepíteni