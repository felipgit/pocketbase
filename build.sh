#!/bin/bash

set -o errexit
set -o nounset

tag=$(curl -s https://api.github.com/repos/pocketbase/pocketbase/releases/latest | jq -r '.tag_name' | tr -d 'v')
old=$(docker image ls felipdocker/pocketbase | head -n 2 | awk '{print $2}' | grep -v TAG)

if [[ "$tag" == "$old" ]]
then
    echo no new version found
    exit 0
fi

echo new version found

sed -i '' 's/ARG PB_VERSION=.*/ARG PB_VERSION='${tag}'/' Dockerfile
docker build -t felipdocker/pocketbase:${tag} .
docker push felipdocker/pocketbase:${tag}
docker tag felipdocker/pocketbase:${tag} felipdocker/pocketbase:latest
docker push felipdocker/pocketbase:latest
docker image rm felipdocker/pocketbase:latest
docker image rm felipdocker/pocketbase:${old}
