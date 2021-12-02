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

ls --help                       - kapcsolók megtekintése

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

history - korábban beírt parancsok
history | head -n 3 && history | tail -n 3 - historyban keresés és szűrés
ls --help                       - kapcsolók megtekintése

mcedit .bashrc                  - aliasok szerkesztése
type pp - 

ls - l -a                       - mappák kilistázása   
ls -lah
ls -lah && echo "sikerült"
ls - l --alapértelmezett        - minden fájlt kiír, a rejtetteket is
chmod 453 textfile.txt          - fájl jogosultság beállítása


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

wc -l mergedfile.txt hány sorból áll a fájl
grep - 
man - 
(head -n2 testfile.txt; tail -n2 textfile.txt) > mergedfile1.txt  - fájl összefűzés


File engedélyek beállítása:
https://www.guru99.com/file-permissions.html
https://chmod-calculator.com/




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