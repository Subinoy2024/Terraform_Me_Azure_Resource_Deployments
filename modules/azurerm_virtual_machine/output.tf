output "vm_names" {
  value = {
    for k, v in azurerm_linux_virtual_machine.this :
    k => v.name
  }
}

output "private_ips" {
  value = {
    for k, v in azurerm_network_interface.this :
    k => v.private_ip_address
  }
}
