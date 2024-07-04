resource "vsphere_virtual_machine" "backend_vms" {
  count            = var.backend_vm_count
  name             = "${var.vm_name_prefix}-backend-${count.index}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_cpu
  memory   = var.vm_memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = var.vm_disk
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.vm_name_prefix}-backend-${count.index}"
        domain    = "local"
      }

      network_interface {
        ipv4_address = "10.0.0.${100 + count.index}"
        ipv4_netmask = 24
      }

      ipv4_gateway = "10.0.0.1"
    }

    provisioner "file" {
      source      = "deploy_backend.sh"
      destination = "/tmp/deploy_backend.sh"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/deploy_backend.sh",
        "/tmp/deploy_backend.sh"
      ]
    }
  }
}

resource "vsphere_virtual_machine" "frontend_vms" {
  count            = var.frontend_vm_count
  name             = "${var.vm_name_prefix}-frontend-${count.index}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_cpu
  memory   = var.vm_memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = var.vm_disk
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.vm_name_prefix}-frontend-${count.index}"
        domain    = "local"
      }

      network_interface {
        ipv4_address = "10.0.0.${200 + count.index}"
        ipv4_netmask = 24
      }

      ipv4_gateway = "10.0.0.1"
    }

    provisioner "file" {
      source      = "deploy_frontend.sh"
      destination = "/tmp/deploy_frontend.sh"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/deploy_frontend.sh",
        "/tmp/deploy_frontend.sh"
      ]
    }
  }
}

resource "vsphere_virtual_machine" "db_vms" {
  count            = var.db_vm_count
  name             = "${var.vm_name_prefix}-db-${count.index}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_cpu
  memory   = var.vm_memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = var.vm_disk
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.vm_name_prefix}-db-${count.index}"
        domain    = "local"
      }

      network_interface {
        ipv4_address = "10.0.0.${300 + count.index}"
        ipv4_netmask = 24
      }

      ipv4_gateway = "10.0.0.1"
    }

    provisioner "file" {
      source      = "deploy_db.sh"
      destination = "/tmp/deploy_db.sh"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/deploy_db.sh",
        "/tmp/deploy_db.sh"
      ]
    }
  }
}
