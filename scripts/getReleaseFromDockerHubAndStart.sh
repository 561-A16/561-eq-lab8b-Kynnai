#!bin/bash
set -v
docker pull kynnai/webapp:release
docker stop $(docker ps -q --filter ancestor=kynnai/webapp:release )
#docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker run -itd -p 6521:5000 kynnai/webapp:release