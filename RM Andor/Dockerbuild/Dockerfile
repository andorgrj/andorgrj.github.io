FROM openjdk:11.0.13-jre-slim-buster
LABEL maintainer=”zeremail15@gmail.com”
RUN mkdir /app
COPY ./my-server.jar /app
WORKDIR /app
EXPOSE 8080
ENTRYPOINT ["java","-jar","./my-server.jar"]