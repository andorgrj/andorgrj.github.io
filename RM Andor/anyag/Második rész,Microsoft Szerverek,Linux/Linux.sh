GRUB 2 Boot -> BIOS -> MBR -> boot.img -> GRUB2 -> core.img -> systemd -t -y -> /etc/rc.local -t -> 

BOOT parancsok
systemd-analyze                 - boot idejének megtekintése
systemd -analize blame          - boot szolgáltatásra bontva
journalctl                      - boot hibák kiíratása
dmesg                           - boot üzenetek kiíratása https://www.howtogeek.com/449335/how-to-use-the-dmesg-command-on-linux/
mc                              - sudo apt install mc /midnight commander
grub2                           - mkconfig -o /boot/grub2/grub.cfg - grub2 újragenerálása
reboot                          - reboot parancs
shutdown -r now                 - kikapcsolás
history                         - eddig általam beírt parancsok kilistázása
shopt                           - bash beállítások
postfix                         - tab kiegészíti a parancsot

ls --help                       - kapcsolók megtekintése
-r                              - rekurzív -> adott könyvtártól lefelé mindenhol végrehajta a kérést

env                             - alapértelmezett változók kiíratása
export valtozo1=neger           - változó létrehozása
echo $valtozo1                  - létrehozott változó kiíratása
unset valtozo1                  - változó törlése
echo $PATH                      - alapértelmezett változó
echo "valtozo2=kocka" > source.txt
source source.txt
echo $valtozo2
set | grep valtozo2             - teljeset kiírja
grep -n World textfile.txt      - keresés a fájlban https://linuxhint.com/find_text_in_files_linux/
echo $?                         - előző parancs visszatérési értéke
man ls                          - parancs felhasználói kézikönyve
ls -l /vvv && echo "van ilyen könyvtár" || mkdir /vvv - könyvtár ellenőtzése, ha nincs létrehozása
echo neger > testfile.txt       - fileba ír
echo neger >> testfile.txt      - file utolsó sorához hozzáfűzi
ls -l /boot/hhh > /dev/null 2>&1 - minden futás közben keletkezett üzenet eltüntetése
ps ax                           - futó folyamatok kilistázása
ls -l /                         - könyvtárak kilistázása az egész fájlrendszerben
man hier                        - man hierachiája
cat /proc/cpuinfo               - cpu információk

User és group kezelés ----------------------------------------------------------------------------------------------------------------------------

sudo-i                          - root felhasználóba lépés
whereis passwd                  - hol van a passwd
nano /etc/passwd                - account infokat tárol
useradd --help                  - user add kapcsolók
useradd testuser1               - felhasználó hozzáadása
deluser                         - felhasználó törlése
userdell -r                     - more secure user delete
sudo delgroup                   - csoport törlése
sudo chgrp testuser4 mergefile.txt - file csoportfelhasználóját módosítja

feladat:-----------------------------------------------------------------------------------------
mkdir grouptestdir
mkdir /grouptestdir/grouptestsubdir
touch file{1..4}
groupadd grouptest 
useradd testuser

chgrp -R grouptest grouptestdir/
cd/grouptestdir
chgrp grouptest grouptestdir
ls -lah

Könyvtárműveletek ---------------------------------------------------------------------------------

cd /                            - rootba lépés
cd ~                            - home könyvtárba lépés
pwd                             - kiírja, hogy melyik könyvtárban vagyunk jelenleg
ls -a                           - fájlokat és a rejtett fájlt is megjeleníti
mkdir -p mydir2/mysubdir2       - mappa és almappa létrehozása ->-p létrehozza a szülő könyvtárat is
rmdir                           - könyvtár törlése
rmdir -p mydir2/mysubdir2       - rekurzívan töröl a -p

chown username file1 file2 ...
chown -R username somedir
chgrp groupname file1 file2 ....
chgrp -R groupname somedir
chown username:groupname file1 file2 ...
---------------------------------------------------------------------------------------------------

sudo -visudo
groupadd testgroup              - csoport létrehozása
sudo useradd -g testgroup groupuser - csoportba ad felhasználót
nmcli
iftop
ps                              - futó folyamatok
ps -aux                         - futó folyamatok részletesebben
pstree                          - futó folyamatok fa ábrán
top                             - folyamatokról és erőforrásokról mutat ábrát
timedatectl                     -
timedatectl set-timezone Europe/Bp - időzóna beállítása
free
df
df -h

Fájlműveletek -------------------------------------------------------------------------------------------------------------------------


history                                         - korábban beírt parancsok
history | head -n 3 && history | tail -n 3      - historyban keresés és szűrés
ls --help                                       - kapcsolók megtekintése
passwd --help
mc -h                                           - midnight commander help
man -?
man -ls                                         - ls manualjai
du                                              - méretét adja ki
whereis ls                                      - hol található az ls
ls -ld testdir                                  - csak a testdir könyvtár kilistázását jelenti
ls -lh /etc/passwd                              - -h kapcsoló a méretet jeleníti meg
cp                                              - fájl másolás
cp myfile myfile.copy_textfile                  - fájl másolása
cp -a                                           - archív opció időbélyeg megtartásával másol
cp -av                                          - archív és verbose -> időbélyeg és kiírja mit csinált /a -v kapcsolóval
cp -av myfile mydir/mysubdir/myfile.copy        - myfilet másolja a mysubdirbe myfile.copy névvel
mv                                              - fájl vagy könyvtár átnevezésére vagy áthelyezésére használjuk
mv readme.txt/mydir2/mysubdir2                  - readme fájlt átrakja a mysubdir2-be
file                                            - fájl típusát mutatja meg
file /etc/passwd
ln -s                                           - szimbólikus link létrehozása /miről hova
ls -l                                           - fájl típusát lehet megnézni
chown                                           - fájltulajdonos módosítás
chgrp                                           - csoporttulajdonos módosítása
chown :testers readme.txt                       - csoporttulajdonos módosítása
chmod                                           - jogosultság módosítások
groupadd                                        - csoport létrehozása
head           head -5 /etc/passwd              - fájl első 10 sorát jeleníti meg / -2 vagy más számmal a sort lehet beállítani
tail           tail -5                          - fájl utolsó 10 sorát jeleníti meg
cat                                             - fájl tartalmát jeleníti meg
tac                                             - visszafelé jeleníti meg a fájl tartalmát
tail -f /var/log/messages                       - log fájl tartalmát jeleníti meg / -f mindig beleírja a legutolsót
rm -rf                                          - fájl törlése rekurzív force!
-------------------------------------------------------------------------------------------------------------------------------------------

Feladat
fájlba írás 

ls -l /www /boot
ls -l /www /boot > stdout.txt
cat stdout.txt
ls -l /www /boot > stdout.txt 2> stderr.txt  ->    hibaüzenet külön fájlba továbbirányítása/kiírása
cat stderr.txt

ls -l /www /boot > stdall.txt 2>&1   -> a kettes üzenetet visszaírányítjuk az 1-be, így lesz egy fájl a hibaüzenettel


grep bash$ /etc/passwd | cut -f1 -d: | sort -> felhasználókat keresi ki / első sorban lévő karakterekkel

--------------------------------------------------------------------------------------------------------------------------------------------

mcedit .bashrc                                  - aliasok szerkesztése
type pp - 

ls - l -a                                       - mappák kilistázása, még a rejtetteké is / rejtettek ponttal kezdődnek   
ls -lah
ls -lah && echo "sikerült"
ls - l --alapértelmezett                        - minden fájlt kiír, a rejtetteket is
chmod 453 textfile.txt                          - fájl jogosultság beállítása https://chmod-calculator.com/


cp testfile.txt copy_textfile.txt - file másolás
cp -a testdirfirst testdir2 - file másolás

mc - fájlműveletek/midnight commander
find /home/andorlts15 -type f
find /home/andorlts15 -name testfile*.*
find /home/andorlts15 -type f -name "*.txt"
-type d - directory
-type f -file

cat testfile.txt - fájl tartalmának kiiratása
cat testfile.txt testfile2.txt > mergedfile.txt   - fájl tartalmának összetűzése
tac testfile.txt - fordítva olvassa vissza a fájlt
tail - fájlban a megadott sort fogja kiírni

wc              - l mergedfile.txt hány sorból áll a fájl
wc -w           - szavakat számolja meg
grep            - fájl tartalmában keres
man             - 
(head -n2 testfile.txt; tail -n2 textfile.txt) > mergedfile1.txt  - fájl összefűzés


File engedélyek beállítása:
https://www.guru99.com/file-permissions.html
https://chmod-calculator.com/

------------------------------------------------------------------------------------------------------------------------------
Hardver monitorozás

lsusb           - csatlakoztatott eszközök megtekintése
lscpu           - gépinformációk
ifconfig        -
nmcli           - hálózathoz lehet csatlakozni
iftop           - hálózati forgalmat lehet figyelni
w               - bejelentkezett felhasználókat jeleníti meg
who             - bejelentkezett felhasználókat jeleníti meg
who -u          - ki van bejelentkezve process id-val látszik / process id-t lehet kikapcsolni pl. kill 1261
top             - ki mit futtat a gépen/ mi fut a gépen
history
history -d      - adott sort lehet törölni /history -d 23
history -c      - egész historyt törölni
nano .bashrc    - aliasokat lehet itt megadni /more aliasok alatt


-------------------------------------------------------------------------------------------------------------------------------

cat /etc/fstab -meghajtó felcsatlakoztatása
dev könyvtárban a külső belső adathordozókat kezeljük
etc - konfiguráció
lib - fájlokat tartalmaz pl dll
opt - dockert ide szokták
tmp - törlődik amit ide ment
cat /etc/resolv.conf
apt install xorg - x-server -> grafikus felület linuxra
xfce - grafikus környezet - szerverre is lehet telepíteni
groups andor - andor csoport miknek a tagja
script indítás ./name.sh
chown :group szerelok
chown szerelok1: howork.sh
chown user:
home könyvtár nélküli user nem tud sudozni, root jelszót ha nem tudja
ffmpeg rakja össze a hangot és képet a letöltött videóhoz

-------------------------------------------------------------------------------------------------------------------------------

könyvtár műveletek
cd change directory átlépés másik könytárba
cd / root könytárba lépés
cd  ~  home könyvtárba lépés
cd .. egy szinttel feljebb lépés
abszolút (/-el kezdődik) relatív útvonal
cd - előző könyvtárba ugrik 
ls: adott könyvtár tartalmának listázása
ls -l listázva mutatja
ls -a mindent mutat rejtett fájlokat is
ls -h human readable olvashatóbb formában mutatja 
ls -lah ultimate :D
mkdir mappa létrehozás
példa mkdir testmappa
pwd megadja az aktuális helyünk abszolút elérési útját
rm törlés 

paraméterek nélkül fájltörlésre való példa rm testfile.txt
-R könytár törlését teszi lehetővé rm -R könytárnév
több leírásban még az olvasható, hogy csak üres mappát töröl. WSL-ben kérdés nélkül töröl akkor is ha van fájl a mappában

f paraméterrel kérdés és figyelmeztetés nékül töröl
linux könytárszerkezete:
bin: felhasználó által indítható alap és telepített programok
boot: grub2 és a kernel fájljait tartalmazza
dev: eszközök eszközfájljai, indításkor generálódnak kikapcsolás után üres
etc: konfigurációs fájlok 
lib: közös fájlok mint windowsban a dll fájlok
media: ma már nem használják
mnt: ideiglenesen csatolt eszközökhöz kell például pendrive
opt: néhány program ide települ
proc: kernelváltozókat tartalmazza futásidőben, nem szabad írni bele
root: rendszergazda könytára
run: futó folyamatok adatait tartalmazza futásidőben
srv: szerverfolyamatok megosztásait szokás ide rakni még most kezd elterjedni a használata
sys: eszközök adatait tartalmazza futásidőben
usr: telepített programok kerülnek ide
var: logok és ideiglenes tárolás, sok írás történik ide 
fájl műveletek
touch fájl létrehozása meglévő fájl időbélyegét módosíthatjuk
cp másolás: 
cp mit hova példa cp testfile1.txt testdir1
ha a célkönyvtár nem létezik akkor létrehozza
paraméter nélkül csak fájl másolását teszi lehetővé és felülírja a célkönytárban lévő verziót
-i (interactive) paraméterrel rákérdez, hogy felülírja-e
-n paraméterrel megtiltjuk hogy felülírja a már létező fájlt
-r paraméterrel könytárat is másolhatunk
-u (update) paraméterrel csak akkor írja felül a célfájlt ha a forrásfájl újabb
a paraméterrel mindent másol rekurzívan
mv áthelyezés/átnevezés
ha másik fájlnevet adunk meg akkor átnevez
file kiírja a file típusát