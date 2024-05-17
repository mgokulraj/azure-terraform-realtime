resource "azurerm_virtual_network" "vnet" {
  name                = "${local.resource_name_prefix}-${var.vnet_name}"
  address_space       = var.vnet_address_space
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = local.common_tags
}

# Web Subnet

resource "azurerm_subnet" "websubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet_address
}

resource "azurerm_network_security_group" "web_subet_nsg" {
  name                = "${azurerm_subnet.websubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "web_subet_nsg_association" {
  depends_on                = [azurerm_network_security_rule.web_nsg_rule_inbound]
  network_security_group_id = azurerm_network_security_group.web_subet_nsg.id
  subnet_id                 = azurerm_subnet.websubnet.id
}

#locals for Security rules
locals {
  web_inbound_ports_map = {
    "100" : "80"
    "110" : "443"
    "120" : "22"
    "130" : "3389"
  }
}

resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  network_security_group_name = azurerm_network_security_group.web_subet_nsg.name
  resource_group_name         = azurerm_resource_group.rg.name
  for_each                    = local.web_inbound_ports_map
  name                        = "Allow-port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = local.source_address_prefix
  destination_address_prefix  = "*"
}

# app Subnet

resource "azurerm_subnet" "appsubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.app_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_subnet_address
}

resource "azurerm_network_security_group" "app_subet_nsg" {
  name                = "${azurerm_subnet.appsubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "app_subet_nsg_association" {
  depends_on                = [azurerm_network_security_rule.app_nsg_rule_inbound]
  network_security_group_id = azurerm_network_security_group.app_subet_nsg.id
  subnet_id                 = azurerm_subnet.appsubnet.id
}

#locals for Security rules
locals {
  app_inbound_ports_map = {
    "100" : "80"
    "110" : "443"
    "120" : "22"
    "130" : "3389"
  }
}

resource "azurerm_network_security_rule" "app_nsg_rule_inbound" {
  network_security_group_name = azurerm_network_security_group.app_subet_nsg.name
  resource_group_name         = azurerm_resource_group.rg.name
  for_each                    = local.app_inbound_ports_map
  name                        = "Allow-port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = local.source_address_prefix
  destination_address_prefix  = "*"
}

# db Subnet

resource "azurerm_subnet" "dbsubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.db_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.db_subnet_address
}

resource "azurerm_network_security_group" "db_subet_nsg" {
  name                = "${azurerm_subnet.dbsubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "db_subet_nsg_association" {
  depends_on                = [azurerm_network_security_rule.db_nsg_rule_inbound]
  network_security_group_id = azurerm_network_security_group.db_subet_nsg.id
  subnet_id                 = azurerm_subnet.dbsubnet.id
}

#locals for Security rules
locals {
  db_inbound_ports_map = {
    "100" : "3389"
    "110" : "443"
    "120" : "22"
    "130" : "1433"
  }
}

resource "azurerm_network_security_rule" "db_nsg_rule_inbound" {
  network_security_group_name = azurerm_network_security_group.db_subet_nsg.name
  resource_group_name         = azurerm_resource_group.rg.name
  for_each                    = local.db_inbound_ports_map
  name                        = "Allow-port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = local.source_address_prefix
  destination_address_prefix  = "*"
}

# bastion Subnet

# resource "azurerm_subnet" "bastionsubnet" {
#   name                 = "${azurerm_virtual_network.vnet.name}-${var.bastion_subnet_name}"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = var.bastion_subnet_address
# }

# resource "azurerm_network_security_group" "bastion_subet_nsg" {
#   name                = "${azurerm_subnet.bastionsubnet.name}-nsg"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# resource "azurerm_subnet_network_security_group_association" "bastion_subet_nsg_association" {
#   depends_on                = [azurerm_network_security_rule.bastion_nsg_rule_inbound]
#   network_security_group_id = azurerm_network_security_group.bastion_subet_nsg.id
#   subnet_id                 = azurerm_subnet.bastionsubnet.id
# }

# #locals for Security rules
# locals {
#   bastion_inbound_ports_map = {
#     "100" : "3389"
#     "110" : "443"
#     "120" : "22"
#   }
# }

# resource "azurerm_network_security_rule" "bastion_nsg_rule_inbound" {
#   network_security_group_name = azurerm_network_security_group.bastion_subet_nsg.name
#   resource_group_name         = azurerm_resource_group.rg.name
#   for_each                    = local.bastion_inbound_ports_map
#   name                        = "Allow-port-${each.value}"
#   priority                    = each.key
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = each.value
#   source_address_prefix       = local.source_address_prefix
#   destination_address_prefix  = "*"
# }