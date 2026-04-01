#!/bin/sh
echo declaramos variables de entorno
DC_HOME=${PWD}/docker_compose
VOLUMES=${PWD}/docker_volumes
ANGULAR_HOME=${PWD}/appsangular
RESOURCES=/app/tikitakas/src/assets

echo iniciamos docker
sudo service docker start

echo eliminamos posibles servicios
docker ps -q | xargs docker rm -f

echo creamos network
docker network create futfem-network

echo lanzar jenkins
docker run --network futfem-network -d --name jenkins -p 8080:8080 -p 50000:50000 -v ${VOLUMES}/jenkins01/:/var/jenkins_home jenkins/jenkins:lts-jdk11

echo lanzamos base de datos futfem
docker-compose -f /home/japerez/docker_compose/mysql-futfem.yml up -d

echo vamos a directorio tikitakas
cd ${ANGULAR_HOME}/tikitakas
echo arrancamos docker compose tikitakas
docker-compose up -d
echo subimos assets
docker cp ${RESOURCES} futfem-front:etc/nginx/html


echo lanzamos kibana
docker-compose -f ${DC_HOME}/kibana-futfem.yml up -d

echo lanzamos microservicios
echo docker-compose -f /home/japerez/docker_compose/microservices-futfem.yml up -d



