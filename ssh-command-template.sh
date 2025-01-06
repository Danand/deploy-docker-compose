#!/bin/bash
#
# Deploys Docker Compose configuration.

set -e

apt update

apt install -y curl git

if [ $(docker --version > /dev/null 2>&1; echo $?) -ne 0 ]; then
  docker_install_script_path="./get-docker.sh"

  curl \
    -fsSL "https://get.docker.com" \
    -o "${docker_install_script_path}"

  chmod +x "${docker_install_script_path}"

  "${docker_install_script_path}"

  rm -f "${docker_install_script_path}"

  apt install -y docker-compose
fi

export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

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

exit 0
