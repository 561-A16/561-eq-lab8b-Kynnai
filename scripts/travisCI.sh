#!bin/bash
set -ev

docker build -t webapp:test -f ./dockerfile/test .
docker run -it --rm -v $PWD/publish:/root/publish -v $PWD/packages:/root/.nuget/packages webapp:test

sudo docker build -t webapp:release -f ./dockerfile/release .

docker tag webapp:release kynnai/webapp:release
docker login -u=$DOCKER_HUB_USERNAME -p=$DOCKER_HUB_PASSWORD
docker push kynnai/webapp:release

scp -o StrictHostKeyChecking=no ./scripts/getReleaseFromDockerHubAndStart.sh 159.203.33.172:6521:~/
ssh 159.203.33.172:6521 "chmod +x getReleaseFromDockerHubAndStart.sh"
ssh 159.203.33.172:6521 "sh getReleaseFromDockerHubAndStart.sh"