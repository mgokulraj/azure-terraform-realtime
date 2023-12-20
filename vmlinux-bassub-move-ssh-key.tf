resource "null_resource" "null_copy_ssh_key" {
  depends_on = [azurerm_linux_virtual_machine.linuxvm_bassub]

  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.linuxvm_bassub.public_ip_address
    user        = azurerm_linux_virtual_machine.linuxvm_bassub.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }

  provisioner "file" {
    source      = "ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem"
  }

  provisioner "remote-exec" {
    inline = ["sudo chmod 400 /tmp/terraform-azure.pem"]
  }
}