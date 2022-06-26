# syntax=docker/dockerfile:1
FROM node:12-alpine
RUN apk add --no-cache python2 g++ make
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "src/index.js"]

docker build -t getting-started .

docker run -dp 3000:3000 getting-started

docker build -t getting-started .

docker run -dp 3000:3000 getting-started

docker stop <the-container-id>

docker rm <the-container-id>

docker run -dp 3000:3000 getting-started

docker tag getting-started YOUR-USER-NAME/getting-started

docker push YOUR-USER-NAME/getting-started

docker run -dp 3000:3000 YOUR-USER-NAME/getting-started

Create a volume
 docker volume create todo-db

docker run -dp 3000:3000 -v todo-db:/etc/todos getting-started

Dive into the volume
 docker volume inspect todo-db  

docker network create todo-app

docker run -d --network todo-app --network-alias mysql -v todo-mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=todos mysql:5.7

To confirm we have the database up and running, connect to the database and verify it connects.
 docker exec -it <mysql-container-id> mysql -u root -p

 mysql > SHOW DATABASES;

Start a new container using the nicolaka/netshoot image. Make sure to connect it to the same network. Connect to SQL.

 docker run -it --network todo-app nicolaka/netshoot

dig mysql

docker run -dp 3000:3000 -w /app -v "$(pwd):/app" --network todo-app -e MYSQL_HOST=mysql -e MYSQL_USER=root -e MYSQL_PASSWORD=secret -e MYSQL_DB=todos node:12-alpine sh -c "yarn install && yarn run dev"

Security scanning
docker scan getting-started

Image history check
docker image history getting-started

