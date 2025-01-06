#!/bin/bash
#
# Deploys Docker Compose configuration via SSH.

set -e

action_path="$1"
github_sha="$2"
ssh_user="$3"
ssh_host="$4"
github_server_url="$5"
github_repository="$6"
docker_compose_profile="$7"
env_file_path="$8"
env_file_content="$9"

github_repo_url="${github_server_url}/${github_repository}"
github_repo_name="$(basename "${github_repository}")"

export GITHUB_SHA="${github_sha}"
export GITHUB_REPO_URL="${github_repo_url}"
export GITHUB_REPO_NAME="${github_repo_name}"

export DOCKER_COMPOSE_PROFILE=""

if [ -n "${docker_compose_profile}" ]; then
  export DOCKER_COMPOSE_PROFILE="--profile=${docker_compose_profile}"
fi

export ENV_FILE_PATH="${env_file_path}"
export ENV_FILE_CONTENT="${env_file_content}"

envsubst \
  ' \
    $GITHUB_REPO_URL \
    $GITHUB_REPO_NAME \
    $DOCKER_COMPOSE_PROFILE \
    $GITHUB_SHA \
    $ENV_FILE_PATH \
    $ENV_FILE_CONTENT \
  ' \
< "${action_path}/ssh-command-template.sh" \
> "${action_path}/ssh-command.sh"

scp "${action_path}/ssh-command.sh" "${ssh_user}@${ssh_host}:~/ssh-command.sh"

ssh "${ssh_user}@${ssh_host}" 'chmod +x ~/ssh-command.sh && ~/ssh-command.sh'

exit 0
