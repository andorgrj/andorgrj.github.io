#!/bin/bash

mkdir -p /home/vizsga2022
cd ~
cd vizsga2022

groupadd forma1pilotak
groupadd ralllypilotak
groupadd nascarpilotak

useradd ayrton_senna -G forma1pilotak -p Nopassw0rd1
useradd alain_prost -G forma1pilotak -p Nopassw0rd1
useradd erik_aaby -G ralllypilotak -p Nopassw0rd1
useradd urmo_aava -G ralllypilotak -p Nopassw0rd1
useradd almirola_aric -G nascarpilotak -p Nopassw0rd1
useradd bilicki_josh -G nascarpilotak -p Nopassw0rd1

history -c

mkdir -p /vizsga2022/szakosztalyok/forma1
mkdir -p /vizsga2022/szakosztalyok/rally
mkdir -p /vizsga2022/szakosztalyok/nascar

chown :forma1pilotak /vizsga2022/szakosztaly/forma1
chown :ralllypilotak /vizsga2022/szakosztaly/rally
chown :nascarpilotak /vizsga2022/szakosztaly/nascar

chmod -R g=rwx /vizsga2022/szakosztaly/forma1pilotak
chmod -R g=rw /vizsga2022/szakosztaly/rallypilotak
chmod g=r /vizsga2022/szakosztaly/nascarpilotak

cd ../..
cd /usr/share 
find . -name '*.txt' | wc -l
cd ~

tail -5 /etc/passwd
cat etc/passwd | grep root