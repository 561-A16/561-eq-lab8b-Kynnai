#!bin/bash
set -v
docker pull $DOCKER_HUB_USERNAME/webapp:release
docker stop $(docker ps -q --filter ancestor=$DOCKER_HUB_USERNAME/webapp:release)
#docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker run -itd -p 6521:5000 $DOCKER_HUB_USERNAME/webapp:release