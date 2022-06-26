#CREATING a containerized Python application using Docker:

mkdir python-docker

cd /path/to/python-docker
pip3 install Flask                                  #follow the steps below to create a simple web server
pip3 freeze | grep Flask >> requirements.txt
touch app.py


#enter the following code into the app.py file.:

from flask import Flask
app = Flask(__name__)
@app.route('/')
def hello_world():
    return 'Hello, Docker!'



python3 -m flask run - ez nem szükséges mert akkor konténer nélkül már indul az alkalmazás


#CREATE Dockerfile in the python-docker directory:

# syntax=docker/dockerfile:1
FROM python:3.8-slim-buster
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY . .
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]


docker build --tag python-docker .

docker run -p 5000:5000 python-docker

docker run -d -p 5000:5000 python-docker

docker logs -f <container id>

#In a new terminal:
curl localhost:5000

--------------------------------------------------------------------------------------------------------------

#First, we’ll take a look at running a database in a container and how we use volumes and networking to persist our data and allow our application to talk with the database. Then we’ll pull everything together into a Compose file which allows us to setup and run a local development environment with one command. Finally, we’ll take a look at connecting a debugger to our application running inside a container.
#Instead of downloading MySQL, installing, configuring, and then running the MySQL database as a service, we can use the Docker Official Image for MySQL and run it in a container.
#Before we run MySQL in a container, we’ll create a couple of volumes that Docker can manage to store our persistent data and configuration.

docker volume create mysql
docker volume create mysql_config

docker network create mysqlnet

docker run --rm -d -v mysql:/var/lib/mysql \
  -v mysql_config:/etc/mysql -p 3306:3306 \
  --network mysqlnet \
  --name mysqldb \
  -e MYSQL_ROOT_PASSWORD=p@ssw0rd1 \
  mysql

docker exec -ti mysqldb mysql -u root -p

#Let’s update the app.py to use MySQL as a datastore:

import mysql.connector
import json
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
  return 'Hello, Docker!'

@app.route('/widgets')
def get_widgets():
  mydb = mysql.connector.connect(
    host="mysqldb",
    user="root",
    password="p@ssw0rd1",
    database="inventory"
  )
  cursor = mydb.cursor()


  cursor.execute("SELECT * FROM widgets")

  row_headers=[x[0] for x in cursor.description] #this will extract row headers

  results = cursor.fetchall()
  json_data=[]
  for result in results:
    json_data.append(dict(zip(row_headers,result)))

  cursor.close()

  return json.dumps(json_data)

@app.route('/initdb')
def db_init():
  mydb = mysql.connector.connect(
    host="mysqldb",
    user="root",
    password="p@ssw0rd1"
  )
  cursor = mydb.cursor()

  cursor.execute("DROP DATABASE IF EXISTS inventory")
  cursor.execute("CREATE DATABASE inventory")
  cursor.close()

  mydb = mysql.connector.connect(
    host="mysqldb",
    user="root",
    password="p@ssw0rd1",
    database="inventory"
  )
  cursor = mydb.cursor()

  cursor.execute("DROP TABLE IF EXISTS widgets")
  cursor.execute("CREATE TABLE widgets (name VARCHAR(255), description VARCHAR(255))")
  cursor.close()

  return 'init database'

if __name__ == "__main__":
  app.run(host ='0.0.0.0')

#We’ve added the MySQL module and updated the code to connect to the database server, created a database and table. We also created a couple of routes to save widgets and fetch widgets. We now need to rebuild our image so it contains our changes.

#First, let’s add the mysql-connector-python module to our application using pip.

pip3 install mysql-connector-python
pip3 freeze | grep mysql-connector-python >> requirements.txt

docker build --tag python-docker-dev .

#Now, let’s add the container to the database network and then run our container. This allows us to access the database by its container name.

docker run \
  --rm -d \
  --network mysqlnet \
  --name rest-server \
  -p 8000:5000 \
  python-docker-dev


#Let’s test that our application is connected to the database and is able to add a note.

 curl http://localhost:8000/initdb
 curl http://localhost:8000/widgets

#You should receive the following JSON back from our service.

[]