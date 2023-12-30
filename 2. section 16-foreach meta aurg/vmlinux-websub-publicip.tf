resource "azurerm_public_ip" "linuxvm_websub_publicip" {
  # count               = var.vmlinux_web_instance_count
  name                = "${local.resource_name_prefix}-linuxvm-web-publicip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}