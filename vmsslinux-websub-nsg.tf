resource "azurerm_network_security_group" "web_vmss_nsg" {
  name                = "${local.resource_name_prefix}-web-vmss-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = var.vmsslinux_web_nsg_ports_inbound
    content {
      name                       = "Allow-port-${security_rule.value}"
      description                = "Allow-port-${security_rule.value}"
      priority                   = sum([100, security_rule.key])
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

# resource "azurerm_network_interface_security_group_association" "web_vmnic_nsg_association" {
#   depends_on                = [azurerm_network_security_rule.web_vmnic_nsg_rule_inbound]
#   network_interface_id      = azurerm_network_interface.vmlinux_websub_nic.id
#   network_security_group_id = azurerm_network_security_group.web_vmnic_nsg.id
# }