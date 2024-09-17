# Terraform Proxmox VMs Provisioning Directory

This is a Terraform project for provisioning Proxmox Virtual Machines (VMs) and creating a Kubernetes (k8s) cluster. To get started, follow these steps:

1. **Setup**: First, make sure you have Terraform installed on your machine(can be done with [shell.nix](../../shell.nix). Navigate to this directory and run the `terraform init` command to initialize the project.

2. **Configure**: The `credentials.auto.tfvars` file is provided for configuring your Proxmox API credentials, IP addresses, and other necessary settings. Update the variables as needed according to your environment.

3. **Plan**: Run the `terraform plan` command to check what resources will be created or modified by Terraform. This helps you visualize the changes before actually applying them.

4. **Apply**: After reviewing the plan, run the `terraform apply` command to provision the Proxmox VMs and create the Kubernetes cluster. Be cautious with this step, as it will make permanent changes to your infrastructure.

The main Terraform files in this directory are:

- **k8s-nodes.tf**: This file is responsible for creating and configuring the Proxmox VMs that will serve as nodes in the Kubernetes cluster.

