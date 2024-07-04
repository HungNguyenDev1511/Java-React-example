output "backend_vm_ips" {
  value = [for vm in vsphere_virtual_machine.backend_vms : vm.default_ip_address]
}

output "frontend_vm_ips" {
  value = [for vm in vsphere_virtual_machine.frontend_vms : vm.default_ip_address]
}

output "db_vm_ips" {
  value = [for vm in vsphere_virtual_machine.db_vms : vm.default_ip_address]
}
