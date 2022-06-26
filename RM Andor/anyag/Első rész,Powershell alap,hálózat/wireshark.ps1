Wireshark T360 kérdéssor:

1. Titkosított formában kommunikálunk -e a szerverrel az első olyan csomagnál, ahol a Request Method: GET? 

    wireshark filter: http.request.method in {"GET"}



2. Mi annak a szervernek az IP címe, amire az első sütit küldtük? 

    wireshark filter: http.cookie



3. Mi a legnagyobb probléma a 1090 keretszámú csomaggal? Mit javasolnál a tulajdonosnak üzemeltetőként?

    HTTP protokollon titkosítatlanum megy az adatforgalom, látszik a csomagban az egyedi azonosító,
    ennek tudatában a hozzáértő személy visszaélhet vele. Tanács az hogy az ilyen kommunikációt mindig
    titkosított HTTPS csatornán kell végezni.



4. Melyik portról küldtük az első DNS lekérdezést?

    wireshark filter : DNS

    Az első DNS csomag a 183-as. A csomagba belenézve látjuk hogy 56925-ös portról küldtük az 53-asra.



5. Volt egy 404 hiba a vizsgált kommunikációban, ha igen milyen címen található? 

    wireshark filter : http.response.code==404

    2 db 404-es hibakódó csomagunk van, az első a 6603-as csomagban, második 8923-as csomagban.
    Nem találta a szerveren a következő fájlt:  http://files.pokerakademia.com/images/design/deck/X.gif


6. Mi a Neve annak a szervernek, amivel elsőnek kezdeményeztünk HTTPS kapcsolatot?

    wireshark filter: tcp.port == 443

    Ez a kérdés lehet becsapós mert:

    A legelső csomag már HTTPS kapcsolatú, de az nem kezdeményezés, hanem már egy korábbi kezdeményezésre adott válasz (ACK)
    Ennek a szervernek a címe 3.67.245.95 nevét nem lehet lekérdezni.


7. Kommunikáltunk -e a training360.com-mal? 


    A training360.com IP címe 40.113.131.37

    wireshark filter: ip.dst == 40.113.131.37

    Igen kommunikáltunk, legelső csomag a 433-as számú amelyben küldjük a SYN-t és próbáljuk felvenni a karcsolatot a szerverrel