resource "azurerm_network_interface" "vmlinux_websub_nic" {
  name                = "${local.resource_name_prefix}-vmlinux-web-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "vmlinux-websub-ip-1"
    subnet_id                     = azurerm_subnet.websubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linuxvm_websub_publicip.id
    # primary                       = true
  }
}