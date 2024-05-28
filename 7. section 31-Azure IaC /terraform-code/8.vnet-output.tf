output "vnet_name" {
  description = "Virtual Network Name"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "web_sub_name" {
  description = "Web Subnet Name"
  value       = azurerm_subnet.websubnet.name
}

output "web_sub_id" {
  description = "Web Subnet ID"
  value       = azurerm_subnet.websubnet.id
}

output "app_sub_name" {
  description = "App Subnet Name"
  value       = azurerm_subnet.appsubnet.name
}

output "app_sub_id" {
  description = "app Subnet ID"
  value       = azurerm_subnet.appsubnet.id
}

# output "db_sub_name" {
#   description = "db Subnet Name"
#   value       = azurerm_subnet.dbsubnet.name
# }

# output "db_sub_id" {
#   description = "db Subnet ID"
#   value       = azurerm_subnet.dbsubnet.id
# }

# output "bastion_sub_name" {
#   description = "bastion Subnet Name"
#   value       = azurerm_subnet.bastionsubnet.name
# }

# output "bastion_sub_id" {
#   description = "bastion Subnet ID"
#   value       = azurerm_subnet.bastionsubnet.id
# }

output "web_nsg_name" {
  description = "Web Subnet NSG Name"
  value       = azurerm_network_security_group.web_subet_nsg.name
}

output "web_nsg_id" {
  description = "Web Subnet NSG ID"
  value       = azurerm_network_security_group.web_subet_nsg.id
}