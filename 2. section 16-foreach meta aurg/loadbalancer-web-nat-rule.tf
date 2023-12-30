resource "azurerm_lb_nat_rule" "lb_web_inbound_nat_rule_22" {
  depends_on = [azurerm_linux_virtual_machine.linuxvm_websub]
  for_each = var.vmlinux_web_instance_count
  # name = "ssh-1022-vm-22"
  name                           = "${each.key}-ssh-${each.value}-vm-22"
  protocol                       = "Tcp"
  frontend_port                  = each.value
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.lb_web.frontend_ip_configuration[0].name
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.lb_web.id
}

resource "azurerm_network_interface_nat_rule_association" "lb_web_nic_nat_rule_association" {
  for_each = var.vmlinux_web_instance_count
  network_interface_id  = azurerm_network_interface.vmlinux_websub_nic[each.key].id
  ip_configuration_name = azurerm_network_interface.vmlinux_websub_nic[each.key].ip_configuration[0].name
  nat_rule_id           = azurerm_lb_nat_rule.lb_web_inbound_nat_rule_22[each.key].id
}