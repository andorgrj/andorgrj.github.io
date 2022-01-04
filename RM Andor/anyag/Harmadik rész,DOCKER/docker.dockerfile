docker version
docker info
docker stats

docker run hello-world - létező image a hubon amit letölt

docker images   - kilistázhatjuk a gépen lévő imageket
docker ps       - ez kilistázza az összes futó konténerünket
docker ps -a    - ezzel a leállított konténereket szintén kilistázhatjuk
docker ps -aq   - összes konténer id-t listázza ki
docker logs <container name> -f - logokat folyamatosan jeleníti meg
docker exec     - a konténeren belül tudunk különféle parancsokat lefuttatni

docker rmi <image-name:tag> / <img-id>           - image törlése
docker rm <container-name> / <container-id>      - konténer törlése

docker image pull <image-name:image-tag>         - A Docker HUB-ról / repositoryból / registryből tudunk lehúzni tetszőleges imageket

docker image inspect <image-name:image:tag>      - Bővebb információk lekérése imageről

docker stop $(docker ps -aq)                     - az összes konténert leállítja egyszerre


imageből konténer a gyakorlatban:

docker image pull nginx:1.21.5-alpine                                                       - image telepítése
docker run --name my-nginx-server -d nginx:1.21.5-alpine                                    - my nginx server nevet adok neki és futtatom szolgáltatásként a háttérben -d vel 
docker exec -it my-nginx-server sh                                                          - inside terminal sh parancssal linux terminal a konténerbe belépve
docker run --name my-nginx-server-w-port -p 60080:80 -d nginx:1.21.5-alpine                 - port megnyitása portátirányítással

index fájl szerkesztése unix:

cat /usr/share/nginx/html/index.html
echo hello docker! > /usr/share/nginx/html/index.html

index fájl szerkesztése win:

PS C:\users\andor> echo hello > index.html
PS C:\users\andor> ls
PS C:\users\andor> docker cp .\index.html my-nginx-server-w-port:/usr/share/nginx/html      - index.html módosítása másolással 


docker image build:

docker image build ./
docker image build -t my-java-server:0.0.1 ./           - elnevezést ad neki a - t-vel : a verziószám
docker image build -t echobean/my-java-server:0.0.1 ./  - névtér alá rakom és így lehet majd publikálni
docker image push echobean/my-java-server:0.0.1
docker run -d --name my-java-server -p 8080:8080 echobean/my-java-server:0.0.1
docker login

