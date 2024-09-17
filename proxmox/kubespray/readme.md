# Kubernetes Cluster Setup with Ansible Inventory for Kubespray Project

This directory contains an Ansible inventory file for setting up a Kubernetes cluster using the
[kubespray](https://kubespray.io) project.

## Setup steps

1. Clone the Kubespray repository and checkout a specific release:
   ```
    git clone https://github.com/kubernetes-sigs/kubespray --branch <version>
   ```
2. Install Ansible:
   ```bash
    VENVDIR=kubespray-venv
    KUBESPRAYDIR=kubespray
    python3 -m venv $VENVDIR
    source $VENVDIR/bin/activate
    cd $KUBESPRAYDIR
    pip install -U -r requirements.txt
   ```
   
### Steps to Rebuild Inventory

1. Navigate to the cloned `kubespray` directory in this project:
   ```bash
    # Copy ``inventory/sample`` as ``inventory/mycluster``
    cp -rfp inventory/sample inventory/mycluster
    
    # Update Ansible inventory file with inventory builder
    declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
    CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
   ```
> NOTE: 
>  - the IPs should match the configuration from [Ansible config](../ansible/hosts.ini) and [Terrafrom config](../terraform/credentials.auto.tfvars)
>  - kubespray inventory will rename the hostnames of your machines so match it from generated "node<num>"
2. Modify the cluster variables according to your cluster requirements.

### Initializing the Cluster

1. Run the following command from the root directory of this project:
   ```bash
   ansible-playbook -i ../proxmox cluster.yaml
   ```

For more detailed information, please refer to the [Kubespray documentation](https://docs.kubespray.io/) and
Ansible documentation for additional customization options.

