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

if [ -d "$GITHUB_REPO_NAME" ]; then
  cd "$GITHUB_REPO_NAME"
  docker-compose down
  git fetch
else
  git clone "$GITHUB_REPO_URL"
  cd "$GITHUB_REPO_NAME"
fi

git checkout --force $GITHUB_SHA

if [ -n "$ENV_FILE_PATH" ]; then
  echo "$ENV_FILE_CONTENT" > "$ENV_FILE_PATH"
fi

docker-compose \
  $DOCKER_COMPOSE_PROFILE \
  up \
  --build \
  --detach
