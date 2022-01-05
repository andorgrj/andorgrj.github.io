Docker multi stage building

C:\Users\Andor\RM\DMultiStageDemo mappába lépve a következő a parancs:

docker image build . -t my-webapp:0.0.1
docker run -d -p 80:80 --name my-webapp my-webapp:0.0.1
docker exec -it my-webapp bash
nginx