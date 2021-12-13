#!/bin/bash

mkdir -p /home/vizsgabash/sportolo/vivo
mkdir -p /home/vizsgabash/sportolo/bokszolo
mkdir -p /home/vizsgabash/sportolo/uszo
mkdir -p /home/vizsgabash/sportolo/userid

groupadd vivo
groupadd bokszolo
groupadd uszo

chgrp vivo -R /home/vizsgabash/sportolo/vivo
chgrp bokszolo -R /home/vizsgabash/sportolo/bokszolo
chgrp uszo -R /home/vizsgabash/sportolo/uszo
chmod 764 -R /home/vizsgabash/sportolo/

useradd -p v31sz0 -g vivo vivo_1
useradd -p v31sz0 -g vivo vivo_2
useradd -p b31sz0 -g bokszolo bokszolo_1
useradd -p b31sz0 -g bokszolo bokszolo_2
useradd -p u31sz0 -g uszo uszo_1
useradd -p u31sz0 -g uszo uszo_2

history -c

echo "userek létrehozva"

find /var/ -size +3M

grep uszo /etc/passwd | head -1 > /home/vizsgabash/sportolo/userid/lekerdezes.txt
tail -3 /etc/passwd >> /home/vizsgabash/sportolo/userid/lekerdezes.txt
cut /etc/passwd -d: -f1,3 | grep 1000* >> /home/vizsgabash/sportolo/userid/lekerdezes.txt






cat /etc/passwd | grep uszo -m 1 >> /home/vizsgabash/sportolo/userid
tail -3 /etc/passwd >> /home/vizsgabash/sportolo/userid
getent passwd {1000..60000} >> /home/vizsgabash/sportolo/userid 