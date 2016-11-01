#!bin/bash
set -ev

docker build -t webapp:test -f ./dockerfile/test .
docker run -it --rm -v $PWD/publish:/root/publish -v $PWD/packages:/root/.nuget/packages webapp:test

sudo docker build -t webapp:release -f ./dockerfile/release .

docker tag webapp:release $DOCKER_HUB_USERNAME/webapp:release
docker login -u=$DOCKER_HUB_USERNAME -p=$DOCKER_HUB_PASSWORD
docker push $DOCKER_HUB_USERNAME/webapp:release

scp -o StrictHostKeyChecking=no ./scripts/getReleaseFromDockerHubAndStart.sh $DOMAINE:~/
ssh $DOMAINE "chmod +x getReleaseFromDockerHubAndStart.sh"
ssh $DOMAINE "sh getReleaseFromDockerHubAndStart.sh"