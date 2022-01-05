Apache webserver 

docker run -d -it --name test-webserver -p 80:80 httpd
docker ps

becsatolás:

find / -type f -name "*.html"
echo hello negerkocka > /usr/local/apache2/htdocs/index.html