# GitHub Actions: Deploy Docker Compose

## Prerequisites

- Debian-based VM

## How to use

Add to your steps at certain job:

```yaml
# Add usage of action:
- name: Deploy Docker Compose configuration
  uses: Danand/deploy-docker-compose@v0.1.2
  with:
    ssh-private-key: '${{ secrets.SSH_PRIVATE_KEY }}' # Required.
    ssh-host: '${{ secrets.SSH_HOST }}'               # Required.
    ssh-user: '${{ secrets.SSH_USER }}'               # Optional. Default: 'root'
    ssh-clone: 'false'                                # Optional. Default: 'false'
    ssh-keep-alive: 'no'                              # Optional. Default: 'yes'
    ssh-alive-interval: '600'                         # Optional. Default: '300'
    docker-compose-profile: 'my-profile'              # Optional. Default: ''
    docker-compose-env-file-path: '.env'              # Optional. Default: ''
    docker-compose-env-file-content: |
      MY_VAR_0=my_value_0
      MY_VAR_1=my_value_1
```

## Notes

If you want to use `ssh-clone: 'true'`, then add the public key corresponding to `${{ secrets.SSH_PRIVATE_KEY }}` to [your GitHub account settings](https://github.com/settings/keys).
