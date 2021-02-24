#!/bin/bash
sudo yum -y update
sudo yum -y install docker

sudo usermod -a -G docker ec2-user
sudo service docker start

docker run -d --restart=on-failure:10 -p ${PORT_EXTERNAL}:${PORT_CONTAINER} \
-e PG_USER=${PG_USER} \
-e PG_HOST=${PG_HOST} \
-e PG_DATABASE=${PG_DATABASE} \
-e PG_PASSWORD=${PG_PASSWORD} \
-e PG_PORT=${PG_PORT} \
${DOCKER_IMAGE}