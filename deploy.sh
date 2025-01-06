#!/bin/bash
#
# Deploys Docker Compose configuration via SSH.

set -e

github_sha="$1"
ssh_user="$2"
ssh_host="$3"
github_server_url="$4"
github_repository="$5"
docker_compose_profile="$6"

github_repo_url="${github_server_url}/${github_repository}"
github_repo_name="$(basename "${github_repository}")"

export GITHUB_SHA="${github_sha}"
export GITHUB_REPO_URL="${github_repo_url}"
export GITHUB_REPO_NAME="${github_repo_name}"

export DOCKER_COMPOSE_PROFILE=""

if [ -n "${docker_compose_profile}" ]; then
  export DOCKER_COMPOSE_PROFILE="--profile=${docker_compose_profile}"
fi

envsubst \
  '$GITHUB_REPO_URL $GITHUB_REPO_NAME $DOCKER_COMPOSE_PROFILE $GITHUB_SHA' \
  < ssh-command-template.sh \
  > ssh-command.sh

scp ssh-command.sh "${ssh_user}@${ssh_host}:~"

ssh "${ssh_user}@${ssh_host}" 'chmod +x ~/ssh-command.sh && ~/ssh-command.sh'

exit 0
