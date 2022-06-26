Apache webserver 

docker run -d -it --name test-webserver -p 80:80 httpd
docker ps

becsatolás:

find / -type f -name "*.html"
echo hello negerkocka > /usr/local/apache2/htdocs/index.html

---------------------------------------------------------------------------------------------------

Networking

Alapvetően az összes konténerünk egy belső bridge alá kerül be. Ami biztosítani fog saját IP címet mindegyiknek. 

docker network ls                           - létező docker hálózatok listázása
docker network inspect <network-name>       - részletes információk a hálózatról
docker network inspect bridge               - láthatjuk, ha fut jelenleg bármilyen konténer, az alapértelmezetten ebbe a networkbe fog bekerülni, ami automatikusan ki is oszt neki egy IP címet

docker network create -d bridge my-network
docker run -d --name my-app1 --network my-network magyarattila90/my-java-app:0.1
docker run -d --name my-app2 --network my-network magyarattila90/my-java-app:0.1
docker exec -it my-app1 bash
:/# ping my-app2
