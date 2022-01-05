Docker Compose

yaml fájlból csinál imageket a konténereknek

a yaml fájl mappájában állva a következő parancsok:

docker compose config
docker compose ps
docker compose top
docker compose logs
docker compose up
docker compose stop
docker compose down                         - leállítja majd törli a konténereket
docker compose down --rmi all --volumes

-------------------------------------------------------------------------------------------

Volume - Kötetek

Ahhoz, hogy meg tudjunk bármi adatot hosszú távon őrizni, egy írható, perzisztens részt kell létrehoznunk, és beállítanunk a konténerhez. Úgynevezett köteteket (volume) kell létrehoznunk, illetve csatolnunk:

docker volume create <volume-name>                                          - létrehoz egy kötetet a megadott névvel
docker volume ls                                                            - kilistázza a jelenlegi köteteket
docker run … -v <volume-name>:/path/to/attach/inside/container <img-name>   - a megadott kötetet csatolni fogja a konténerünk belsejéhez, a megadott útvonalra, ez azt jelenti, hogy bármi amit a konténerben abban a mappában írunk, azt a kötetünk fog kezelni
Ezen kívül csatolhatunk létező, fizikai helyeket is a számítógéünkről.
Ebben az esetben annyi a teendőnk, hogy konténer indításnál, a kötetnév helyett a bekötni kívánt könyvtár abszolút elérési útját adjuk meg

docker run -d -name name_of_container -p 80:8080 
                - d detach, run in background
                --name név megadása
                - v mysqldata:/var/lib/mysql
                - p port-mapping

docker run -it -name temp ubuntu:20.04 /bin/bash
                -it inside terminal (nem ajánlott)
                /bin/bash give me bash