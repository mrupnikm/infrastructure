# Proxmox Infrastructure Setup Guide 

This guide will walk you through setting up a Proxmox infrastructure using Terraform and Ansible. Make sure you
have already installed Proxmox on your hardware and gained SSH connectivity to it.

## 1. Bootstrap Proxmox
Follow the instructions in this guide to bootstrap your Proxmox environment using Ansible. [Bootstrap
Proxmox](ansible/readme.md#bootstrap-proxmox-after-initialization)

## 2. Get the API Token
Learn how to obtain your Proxmox API token by following the steps in this guide. [Get API Token](ansible/readme.md#create-proxmox-api-token-for-terraform-usage)

## 3. Create Storage
Create custom storage pools and LVM volumes for use with your VMs. You can find the instructions here. [Create
Storage](ansible/readme.md#create-storage-instance-on-proxmox)

## 4. Create VMs
Once you have the necessary storage, create and configure your VMs using this guide. [Create VMs](terraform/readme.md)

## 4.1. Kubespray Installation with Inventory
Set up a Kubernetes cluster on your Proxmox environment using kubespray. Follow the instructions in this guide to
create an inventory file and apply it with ansible. [Kubespray Installation](kubespray/readme.md)

## 4.2. Apply Charts with ArgoCD
Deploy applications on your Kubernetes cluster using Helm charts and ArgoCD. Find the instructions here.
[Kubespray Installation](charts)