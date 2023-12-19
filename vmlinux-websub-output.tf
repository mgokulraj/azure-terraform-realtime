## Public IP Address
output "linuxvm_websub_public_ip" {
  description = "Web Linux VM Public IP Address"
  value = azurerm_public_ip.linuxvm_websub_publicip.ip_address
}

# Network Interface Outputs
## Network Interface ID
output "linuxvm_websub_nic_id" {
  description = "Web Linux VM Network Interface ID"
value = azurerm_network_interface.vmlinux_websub_nic.id
}
## Network Interface Private IP Addresses
output "linuxvm_websub_nic_private_ip_address" {
  description = "Web Linux VM Private IP Addresses"
  value = azurerm_network_interface.vmlinux_websub_nic.private_ip_address
}

## Virtual Machine Public IP
output "linuxvm_websub_public_ip_address" {
  description = "Web Linux Virtual Machine Public IP"
  value = azurerm_linux_virtual_machine.linuxvm_websub.public_ip_address
}

## Virtual Machine Private IP
output "linuxvm_websub_private_ip_address" {
  description = "Web Linux Virtual Machine Private IP"
  value = azurerm_linux_virtual_machine.linuxvm_websub.private_ip_address
}

## Virtual Machine 128-bit ID
output "linuxvm_websub_vm_id_128bit" {
  description = "Web Linux Virtual Machine ID - 128-bit identifier"
  value = azurerm_linux_virtual_machine.linuxvm_websub.virtual_machine_id
}
## Virtual Machine ID
output "linuxvm_websub_vm_id" {
  description = "Web Linux Virtual Machine ID "
  value = azurerm_linux_virtual_machine.linuxvm_websub.id
}