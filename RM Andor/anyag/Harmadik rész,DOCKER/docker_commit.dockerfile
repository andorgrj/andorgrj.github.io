DOCKER COMMIT - futó konténerből imaget csinálunk majd a konténerben változtatunk valamit és a változást commitoljuk

docker image ls
docker run -d -p 80:80 echobean/andor-java-app:0.0.1
docker ps
docker exec -it determined_johnson bash
touch /hello.txt
echo hello docker >> hello.txt
cat hello.txt
docker commit determined_johnson my-java-app:0.0.2
docker image ls