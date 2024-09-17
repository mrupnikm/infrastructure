# Proxmox Ansible Automation Scripts

This repository contains a set of Ansible playbooks designed to automate the setup and management of Proxmox VE servers, as well as Kubernetes (K8s) nodes. The following playbooks are included:

## Configuration

All configuration is centralized in `/group_vars/all.yaml`. By utilizing this file, you can easily manage and update your Proxmox servers without having to modify each playbook individually. This design choice also encourages
consistency across your environment by ensuring that all servers are configured according to the same settings.

## Bootstrap Proxmox after initialization

This playbook installs [Tailscale](https://tailscale.com/) on the machine, providing a zero-config secure VPN for all your machines. To run this playbook, use the following command:

```bash
ansible-playbook bootstrap_proxmox.yaml -i inventory.ini --ansible_user=<username>"
```

Replace `<username>` with the appropriate username for your Proxmox server.

## Create Proxmox API token for Terraform usage

This playbook configures a Proxmox API token and displays it. To run this playbook, use the following command:

```bash
ansible-playbook create_api_token.yaml -i inventory.ini --ansible_user=<username>"
```

Replace `<username>` with the appropriate username for your Proxmox server.

## Create cloud image VM template on Proxmox

This playbook creates a cloud VM image and makes it a Proxmox VM template. To run this playbook, use the following command:

```bash
ansible-playbook create_cloud_image.yaml -i inventory.ini ---ansible_user=<username>"
```

Replace `<username>` with the appropriate username for your Proxmox server.

## Create storage instance on Proxmox

This playbook configures a filesystem volume on Proxmox. To run this playbook, use the following command:

```bash
ansible-playbook create_storage.yaml -i inventory.ini ---ansible_user=<username>"
```

Replace `<username>` with the appropriate username for your Proxmox server.

## Post install tasks on K8s nodes created by Terraform

This playbook is used to upgrade and add [Tailscale installation](https://tailscale.com/) on Kubernetes (K8s) VM nodes once they have already been created. To run this playbook, use the following command:

```bash
ansible-playbook bootstrap_k8s_nodes.yaml -i k8s_inventory.ini --ansible_user=<username>" 
```

Replace `<username>` with the appropriate username for your Proxmox server. 