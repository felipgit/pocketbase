#!/bin/bash

set -o errexit
set -o nounset

tag=0.11.2

sed -i '' 's/ARG PB_VERSION=.*/ARG PB_VERSION='${tag}'/' Dockerfile
docker build -t felipdocker/pocketbase:${tag} .
docker push felipdocker/pocketbase:${tag}

