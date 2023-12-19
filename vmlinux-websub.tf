resource "azurerm_linux_virtual_machine" "linuxvm_websub" {
  name                  = "${local.resource_name_prefix}-linuxvm-websub"
  computer_name         = "webserver"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_DS1_v2"
  admin_username        = "rsadmin"
  network_interface_ids = [azurerm_network_interface.vmlinux_websub_nic.id]
  admin_ssh_key {
    username   = "rsadmin"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")
}