locals {
  webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to devops - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to devops - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to devops - WebVM App1 - App Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to devops - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app1/metadata.html
CUSTOM_DATA  
}
resource "azurerm_linux_virtual_machine_scale_set" "vmsslinux_websub" {
  name = "${local.resource_name_prefix}-linuxvmss-websub"
  # computer_name         = "webserver"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = Standard_DS1_v2
  instances           = 2

  admin_username = "rsadmin"
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

  upgrade_mode = "Automatic"

  network_interface {
    name                      = "vmss-websub-nic"
    primary                   = true
    network_security_group_id = azurerm_network_security_group.vmsslinux_web_nsg.id
    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.websubnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb_web_backend_address_pool.id]
    }
  }
  custom_data = base64encode(local.webvm_custom_data)

}
