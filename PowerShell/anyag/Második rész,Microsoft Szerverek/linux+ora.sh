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

while :; do date > pipe ; sleep 1s ; done &
jobs
fg - forgroundba küldöm a jobot
cat pipe
bg - backgroundba küldöm a jobot
cat pipe

kill %1 -utolsó jobot bezárja

rm -rf a* b* c*  - rm törlés haladó változat

rm -r  - remove rekurzívan, teljes mappát és almappát tartalommal együtt törli

touch d/e - d-ben hozza az e-t létre
chmod -w d/e - writeot elvesszük tőle

rm -rf - force rekurzív eltávolítás
rm - i - megkérdezi törlés előtt a törlést

ls -lh /var/log
ls -lhS - méret szerint rendezi a fájlokat
ls -lht - t módosítás ideje szerint rendezi a fájlokat
ls -lha - rejtett fileokat is megmutatja
ls -lh --group-directories-first /var/log - minden könyvtár a lista elejére kerül, utána jönnek a fájlok


másolás:
touch g 
ls -lh
cp g h
ls -lh
rm g h
cp -a - mindent másol rekurzívan, még a fájl jogosultságokat is 

mv i n - átnevezés: iből n lett
mv * o - mindent az o könyvtárba tesz be


mv j/k n/ - felülírja 


tulajdonos az első, csoport a második
chgrp - csoportját tudom átállítani
chown - tulajdonost lehet módosítani 
chown tulajdonos:csoport  - a tulajdonost és csoportot egyszerre megadva lehet módosítani kettősponttal
chown :csoport - jogosultság állítás csak a csoportra vonatkozóan a kettőspont után

chmod -r - olvasás jogot veszem el
chmod +r - olvasás jogot adom hozzá
chmod u/user g/group o/others - jogokat lehet módosítani




ls -lhd /tmp - -d kapcsoló a könytárat listázza nem a tartalmát

mkdir p
date > p/q
cat p/q
ls -lh


umask - itt lehet állítani a létrejövő fájl jogosultságait

ls -lhR - teljes könyvtárstruktúrát mutatja
tree -h - ember által olvasható méret formában mutatja

find - könytárakat, fájlokat kiírja
find -type d - könyvtár típusú fájlokat listázza k
find -cmin +60 - legalább 60 perce módosított fájlokat írja ki
find -cmin -10 - 10 percen belül módosított fájlokat keresi
find -ctime -1 - elmúlt 1 napban módosult fájlokat írja ki
find -atime -1 - file access timeot írja ki
find -mmin -300 - módosult fájlok listája
find -user andor - andor nevű tulajdonost keresi meg
find -group sudo - sudo csoportot keresi meg
find -print
{} \; - összes fájlt jelenti tömeges módosításhoz
find -group andor -exec chgrp sudo {} \;




szimblikus linkek - nem lehet állítani a jogosultságát
touch y
ln - szimbólikus link létrehozása
echo * - csillag az összes karaktert helyettesíti, keresi
ls -lh a* - csillag az összes karaktert helyettesíti, keresi
ls -lh a? - ? egy konkrét karaktert helyettesít


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
ls -lh a ab abc >e - egyes üzenet átirányítása
ls -lh a ab abc >e 2>&1 - egyes és kettes üzenet egy fájlba írányítása
&>e - összes üzenet egy fájlba irányítása



ls -lh a ab


átirányításokat fordítva hajtja végre

Több parancs egybefűzése:
ls - lh a ab ; echo hello - mindkét parancsot kiadja
;  - parancs elválasztása, mindkettőt kiadja
|| - akkor futtatom a második parancsot ha az első eredménye nem jó
&& - második csak akkor fut le ha az első parancs sikeres


find > results
grep k results      - results nevűben a k-t keresi meg
grep -i k results   - kis és nagy betűs k-t keres
grep -v k results   - azokat a fájlokat keresi amiben nincs k

touch K
find -v K - -v-vel az olyat keresi amiben nincs "nagy K"
grep -r

head /etc/passwd
head -5
tail 
tail -5
tail -F             - mappa tartalmát folyamatossan kiírja
tail -F             - nagy f a fájlt határozza meg
less
cut

tar cf - egybefűzi a fájlt?
gzip - összetömörít és az eredetit törli
gunzip - kicsomagol

du                              - disk usage
du -shc *                       - disk usage olvasható mérettel
du -shc | sort -hr              - fájlok méretét adja meg rendezett formában
ncdu                            - grafikus felülettel jeleníti meg a fájlméreteket
df                              - foglaltság állapota
df -h                           - foglaltság byte-ban



ctrl + a  - legeleje
ctrl + e  - legvégére
ctrl + u  - elejéig visszatöröl
ctrl + w  - szavanként töröl visszafelé
ctrl + k  - sor végét törli
