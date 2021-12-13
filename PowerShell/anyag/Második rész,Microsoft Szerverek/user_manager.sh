#!/bin/bash

mkdir vizsgabash

sudo groupadd vivo
sudo groupadd bokszolo
sudo groupadd uszo

sudo useradd --password v31sz0 --gid vivo --create-home --/home/vizsgabash vivo_1               
sudo useradd --password v31sz0 --gid vivo --create-home --/home/vizsgabash vivo_2 
sudo useradd --password b31sz0 --gid bokszolo --create-home --/home/vizsgabash bokszolo_1
sudo useradd --password b31sz0 --gid bokszolo --create-home --/home/vizsgabash bokszolo_2
sudo useradd --password u31sz0 --gid uszo --create-home --/home/vizsgabash uszo_1
sudo useradd --password u31sz0 --gid uszo --create-home --/home/vizsgabash uszo_2

history -c

usermod -aG vivo vivo_1 vivo_2
usermod -aG vivo bokszolo_1 bokszolo_2
usermod -aG vivo uszo_1 uszo_2

chgrp 664 /home/vizsgabash/sportolo/vivo
chgrp 664 /home/vizsgabash/sportolo/bokszolo
chgrp 664 /home/vizsgabash/sportolo/uszo

cd var

cp /etc/passwd /home/vizsgabash/sportolo/userid

find /var/ -size +3M | grep uszo | head -n 1
grep bash$ /etc/passwd | cut -f1 -d: | sort




groupadd vivo
groupadd bokszolo
groupadd uszo

useradd -m -p v31sz0 vivo_1 -G vivo
useradd -m -p v31sz0 vivo_2 -G vivo
useradd -m -p b31sz0 bokszolo_1 -G bokszolo
useradd -m -p b31sz0 bokszolo_2 -G bokszolo
useradd -m -p u31sz0 uszo_1 -G uszo
useradd -m -p u31sz0 uszo_2 -G uszo

mkdir -p /home/vizsgabash/sportolo/vivo
mkdir -p /home/vizsgabash/sportolo/bokszolo
mkdir -p /home/vizsgabash/sportolo/uszo

chgrp vivo /home/vizsgabash/sportolo/vivo/
chgrp bokszolo /home/vizsgabash/sportolo/bokszolo
chgrp uszo /home/vizsgabash/sportolo/uszo

chmod 764 /home/vizsgabash/sportolo/vivo/
chmod 764 /home/vizsgabash/sportolo/bokszolo/
chmod 764 /home/vizsgabash/sportolo/uszo/

find /var/ -size +3M | grep uszo | head -n 1 > /home/vizsgabash/sportolo/userid

cat /etc/passwd/ | tail -n 3 >> /home/vizsgabash/sportolo/userid

