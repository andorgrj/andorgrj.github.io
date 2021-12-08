Crontab használata / időzített indításra

timedatectl                                 - időzóna lekérdezése
timedatectl list-timezones                  - használatos időzóna beállítása
timedatectl set-timezone Europe/Budapest    - időzóna beállítása
 

 crontab -e -> ebbe lehet írni, hogy mit akarok mikor

 nano frissítés.sh -> ebbe a fájlba írtuk a sudo apt update kérést
 sh frissítés.sh -> lefuttatom


Archíválás

#!/bash/bin

tar -cvf /home/archiv/archiv1.tar /home/files -> első részben megadom hova készítse a tar fájl, másodikban az elkészített fájl helyét adom meg

 


