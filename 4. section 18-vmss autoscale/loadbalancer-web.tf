resource "azurerm_public_ip" "lb_web_pip" {
  name                = "${local.resource_name_prefix}-lb-web-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags
}

resource "azurerm_lb" "lb_web" {
  name                = "${local.resource_name_prefix}-lb-web"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  tags                = local.common_tags

  frontend_ip_configuration {
    name                 = "lb-web-pip-1"
    public_ip_address_id = azurerm_public_ip.lb_web_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_web_backend_address_pool" {
  name            = "lb-web-backed-pool"
  loadbalancer_id = azurerm_lb.lb_web.id
}

resource "azurerm_lb_probe" "lb_web_probe" {
  name            = "tcp-probe"
  protocol        = "Tcp"
  port            = 80
  loadbalancer_id = azurerm_lb.lb_web.id
}

resource "azurerm_lb_rule" "lb_web_rule_app1" {
  name                           = "web-app1-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lb_web.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_web_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.lb_web_probe.id
  loadbalancer_id                = azurerm_lb.lb_web.id
}

# resource "azurerm_network_interface_backend_address_pool_association" "lb_web_nic_association" {
#   for_each                = var.vmlinux_web_instance_count
#   network_interface_id    = azurerm_network_interface.vmlinux_websub_nic[each.key].id
#   ip_configuration_name   = azurerm_network_interface.vmlinux_websub_nic[each.key].ip_configuration[0].name
#   backend_address_pool_id = azurerm_lb_backend_address_pool.lb_web_backend_address_pool.id
# }