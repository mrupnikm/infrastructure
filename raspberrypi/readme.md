# Ansible Repository
This repository contains content for deploying a Gitea server with its Docker environment,
along with its Runner and Tailscale using Ansible Playbooks. The configuration for this deployment can be found in
the `group_vars/all.yml` file.

## Requirements

- Ensure that you have the necessary SSH keys for connecting to the target server (ssh-copy-id).

## Usage

1. Edit the `hosts.ini` file to include the target server's details.
2. Update the configuration settings in the `group_vars/all.yml` file as required.
3. After configuring the files, run the following command to deploy the Gitea server:
   ```
   ansible-playbook -i hosts.ini init-gitea.yml
   ```
4. Once the deployment is successful, configure the Gitea settings as needed and manually connect Tailscale after
   running the playbook **(check tailscale container logs)**.

>## Important Notes
>
>- The initial installation of Gitea does not generate a token automatically, so you'll need to generate one from
>  the Gitea web interface and set it in the `group_vars/all.yml` file and than run `update-gitea.yml` playbook

