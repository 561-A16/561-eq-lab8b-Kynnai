#!bin/bash
set -v
docker pull kynnai/webapp:release
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker run -itd -p 8024:5000 kynnai/webapp:release