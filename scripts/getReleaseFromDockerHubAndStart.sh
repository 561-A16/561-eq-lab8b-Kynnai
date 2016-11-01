#!bin/bash
set –v
docker $DOCKER_HUB_USERNAME/webapp:release
docker stop $DOCKER_HUB_USERNAME/webapp:release
docker rm $DOCKER_HUB_USERNAME/webapp:release
docker run -itd -p 6521:5000 $DOCKER_HUB_USERNAME/webapp:release