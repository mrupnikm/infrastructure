variable "proxmox_image_ciuser" {
  type = string
}
variable "proxmox_image_cipassword" {
  type = string
}
variable "proxmox_image_sshkeys" {
  type = string
}

variable "k8-nodes" {
  default = {
    vm1 = {
      name      = "cp1"
      vmid      = "200"
      memory    = 2048
      cores     = 2
      ipconfig0 = "ip=192.168.1.20/24,gw=192.168.1.1"
      clone     = "ubuntu-cloud-noble"
    }
    vm2 = {
      name      = "wk1"
      vmid      = "300"
      memory    = 4096
      cores     = 4
      ipconfig0 = "ip=192.168.1.30/24,gw=192.168.1.1"
      clone     = "ubuntu-cloud-noble"
    }
    vm3 = {
      name      = "wk2"
      vmid      = "310"
      memory    = 4096
      cores     = 4
      ipconfig0 = "ip=192.168.1.40/24,gw=192.168.1.1"
      clone     = "ubuntu-cloud-noble"
    }
  }
}
resource "proxmox_vm_qemu" "k8s_vms" {
  for_each = var.k8-nodes
  name     = each.value.name

  vmid        = each.value.vmid
  nameserver  = "9.9.9.9"
  target_node = "proxmox"
  full_clone  = true
  agent       = 1
  onboot      = true
  hotplug     = "disk,network,usb"
  clone       = each.value.clone
  cores       = each.value.cores
  sockets     = 1
  cpu         = "host"
  memory      = each.value.memory
  scsihw      = "virtio-scsi-pci"
  os_type     = "cloud-init"
  ipconfig0   = each.value.ipconfig0
  ciuser      = var.proxmox_image_ciuser
  cipassword  = var.proxmox_image_cipassword
  sshkeys     = var.proxmox_image_sshkeys

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  serial {
    id   = 0
    type = "socket"
  }
  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "main"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = "32G"
          storage = "main"
        }
      }
    }
  }
}
