#!/bin/bash
#
# Deploys Docker Compose configuration.

apt update

apt install -y curl git

curl \
  -fsSL "https://get.docker.com" \
  -o "get-docker.sh"

chmod +x ./get-docker.sh

./get-docker.sh

apt install -y docker-compose

if [ ! -d "$GITHUB_REPO_NAME" ]; then
  git clone "$GITHUB_REPO_URL"
  cd "$GITHUB_REPO_NAME"
else
  cd "$GITHUB_REPO_NAME"
  git fetch
  git checkout $GITHUB_SHA
fi

docker-compose down

docker-compose \
  $DOCKER_COMPOSE_PROFILE \
  up \
  --build \
  --detach
