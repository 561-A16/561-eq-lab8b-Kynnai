#!bin/bash
set -ev

docker build -t webapp:test -f ./dockerfile/test .
docker run -it --rm -v $PWD/publish:/root/publish -v $PWD/packages:/root/.nuget/packages webapp:test

sudo docker build -t webapp:release -f ./dockerfile/release .

docker tag webapp:release kynnai/webapp:release
docker login -u=kynnai -p=$mdpDockerHub
docker push kynnai/webapp:release

scp -o StrictHostKeyChecking=no ./scripts/getReleaseFromDockerHubAndStart.sh u1462507@159.203.33.172:~/
ssh u1462507@159.203.33.172 "chmod +x getReleaseFromDockerHubAndStart.sh"
ssh u1462507@159.203.33.172 "sh getReleaseFromDockerHubAndStart.sh"