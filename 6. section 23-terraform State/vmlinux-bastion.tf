# # Locals Block for custom data
# locals {
#   bastion_host_custom_data = <<CUSTOM_DATA
# #!/bin/sh
# #sudo yum update -y
# sudo yum install -y httpd
# sudo systemctl enable httpd
# sudo systemctl start httpd  
# sudo systemctl stop firewalld
# sudo systemctl disable firewalld
# sudo yum install -y telnet
# sudo chmod -R 777 /var/www/html 
# sudo echo "Welcome to stacksimplify - Bastion Host - VM Hostname: $(hostname)" > /var/www/html/index.html
# CUSTOM_DATA  
# }

# resource "azurerm_public_ip" "linuxvm_bassub_publicip" {
#   name                = "${local.resource_name_prefix}-linuxvm-bastion-publicip"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_network_interface" "vmlinux_bassub_nic" {
#   name                = "${local.resource_name_prefix}-vmlinux-bastion-nic"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   ip_configuration {
#     name                          = "vmlinux-bastion-ip-1"
#     subnet_id                     = azurerm_subnet.bastionsubnet.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.linuxvm_bassub_publicip.id
#     primary                       = true
#   }
# }

# resource "azurerm_linux_virtual_machine" "linuxvm_bassub" {
#   name                  = "${local.resource_name_prefix}-linuxvm-bastion"
#   computer_name         = "bastionserver"
#   resource_group_name   = azurerm_resource_group.rg.name
#   location              = azurerm_resource_group.rg.location
#   size                  = "Standard_DS1_v2"
#   admin_username        = "rsadmin"
#   network_interface_ids = [azurerm_network_interface.vmlinux_bassub_nic.id]
#   admin_ssh_key {
#     username   = "rsadmin"
#     public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
#   }
#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
#   source_image_reference {
#     publisher = "RedHat"
#     offer     = "RHEL"
#     sku       = "83-gen2"
#     version   = "latest"
#   }
#   custom_data = base64encode(local.bastion_host_custom_data)
# }