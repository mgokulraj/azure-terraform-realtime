/*
resource "azurerm_resource_group" "devops" {
  name     = "devops"
  location = "south india"
}

resource "azurerm_virtual_network" "dev-vn" {
  name                = "dev-vnet"
  resource_group_name = azurerm_resource_group.devops.name
  location            = azurerm_resource_group.devops.location
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "name" {
  name                 = "dev-subnet1"
  virtual_network_name = azurerm_virtual_network.dev-vn.name
  address_prefixes     = ["10.10.1.0/24"]
  resource_group_name  = azurerm_resource_group.devops.name
}

resource "azurerm_storage_account" "devstor" {
  count                    = 2
  name                     = "dev123stor345${random_string.randomstring.result}${count.index}"
  resource_group_name      = azurerm_resource_group.devops.name
  location                 = azurerm_resource_group.devops.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on               = [azurerm_resource_group.devops, azurerm_virtual_network.dev-vn]
}

# resource "azurerm_storage_container" "backup" {
#   name                  = "backup"
#   storage_account_name  = azurerm_storage_account.devstor.name
#   container_access_type = "private"
#   depends_on = [ azurerm_storage_account.devstor ]
# }

resource "random_string" "randomstring" {
  lower   = true
  upper   = false
  length  = 4
  special = false
  numeric = false
}
*/