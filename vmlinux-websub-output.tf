## Public IP Address
# output "linuxvm_websub_public_ip" {
#   description = "Web Linux VM Public IP Address"
#   value       = azurerm_public_ip.linuxvm_websub_publicip.ip_address
# }

# Network Interface Outputs
## Network Interface ID
output "linuxvm_websub_nic_id" {
  description = "Web Linux VM Network Interface ID"
  # value       = azurerm_network_interface.vmlinux_websub_nic[*].id
  value = [for vm in azurerm_network_interface.vmlinux_websub_nic : vm.id]
}
## Network Interface Private IP Addresses
output "linuxvm_websub_nic_private_ip_address_list" {
  description = "Web Linux VM Private IP Addresses"
  # value       = azurerm_network_interface.vmlinux_websub_nic[*].private_ip_address -> This is output for count meta arugument
  value = [for vm in azurerm_network_interface.vmlinux_websub_nic : vm.private_ip_address]
}

output "linuxvm_websub_nic_private_ip_address_map" {
  description = "Web Linux VM Private IP Address in map format"
  value       = { for vm in azurerm_network_interface.vmlinux_websub_nic : vm.name => vm.private_ip_address }
}

## Virtual Machine Public IP
# output "linuxvm_websub_public_ip_address" {
#   description = "Web Linux Virtual Machine Public IP"
#   value       = azurerm_linux_virtual_machine.linuxvm_websub.public_ip_address
# }

## Virtual Machine Private IP
output "linuxvm_websub_private_ip_address_vmname" {
  description = "Web Linux Virtual Machine Private IP"
  value       = keys({ for vm in azurerm_network_interface.vmlinux_websub_nic : vm.name => vm.private_ip_address })
}

output "linuxvm_websub_private_ip_address_ip" {
  description = "Web Linux Virtual Machine Private IP"
  value       = values({ for vm in azurerm_network_interface.vmlinux_websub_nic : vm.name => vm.private_ip_address })
}

output "linuxvm_websub_nic_id_list" {
  description = "Web Linux VM Network Interface ID"
  value       = [for vm, nic in azurerm_network_interface.vmlinux_websub_nic : nic.id]
}

output "linuxvm_websub_nic_id_map" {
  description = "Web Linux VM Network Interface ID"
  value       = { for vm, nic in azurerm_network_interface.vmlinux_websub_nic : vm => nic.id }
}