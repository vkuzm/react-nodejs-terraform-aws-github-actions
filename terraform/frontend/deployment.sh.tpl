#!/bin/bash
sudo yum -y update
sudo yum -y install docker

sudo usermod -a -G docker ec2-user
sudo service docker start

docker run -d --restart=on-failure:10 -p ${PORT_EXTERNAL}:${PORT_CONTAINER} \
${DOCKER_IMAGE}