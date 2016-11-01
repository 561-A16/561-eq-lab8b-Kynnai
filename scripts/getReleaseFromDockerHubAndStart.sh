#!bin/bash
set –v
docker kynnai/webapp:release
docker stop kynnai/webapp:release
docker rm kynnai/webapp:release
docker run -itd -p 6521:5000 kynnai/webapp:release
