# GitHub Actions: Deploy Docker Compose

## Prerequisites

- Debian-based VM

## How to use

Add to your steps at certain job:

```yaml
# Add usage of action:
- name: Deploy Docker Compose configuration
  uses: Danand/deploy-docker-compose@v0.1.0
  with:
    ssh-private-key: '${{ secrets.SSH_PRIVATE_KEY }}' # Required.
    ssh-host: '${{ secrets.SSH_HOST }}'               # Required.
    ssh-user: '${{ secrets.SSH_USER }}'               # Optional. Default: 'root'
    docker-compose-profile: 'my-profile'              # Optional. Default: ''
    docker-compose-env-file-path: '.env'              # Optional. Default: ''
    docker-compose-env-file-content: |
      MY_VAR_0=my_value_0
      MY_VAR_1=my_value_1
```
