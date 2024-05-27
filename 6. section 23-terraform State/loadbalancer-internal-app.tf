# ****** Public IP is not required as this is internal load balancer ******

# resource "azurerm_public_ip" "lb_app_pip" {
#   name                = "${local.resource_name_prefix}-lb-app-pip"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   allocation_method   = "Static"
#   sku                 = "Standard"
#   tags                = local.common_tags
# }

resource "azurerm_lb" "lb_app" {
  name                = "${local.resource_name_prefix}-lb-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  tags                = local.common_tags

  frontend_ip_configuration {
    name                          = "lb-app-pip-1"
    subnet_id                     = azurerm_subnet.appsubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    private_ip_address            = "10.1.11.241"
    # public_ip_address_id = azurerm_public_ip.lb_app_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_app_backend_address_pool" {
  name            = "lb-app-backed-pool"
  loadbalancer_id = azurerm_lb.lb_app.id
}

resource "azurerm_lb_probe" "lb_app_probe" {
  name            = "tcp-probe"
  protocol        = "Tcp"
  port            = 80
  loadbalancer_id = azurerm_lb.lb_app.id
}

resource "azurerm_lb_rule" "lb_app_rule_app1" {
  name                           = "app-app1-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lb_app.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_app_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.lb_app_probe.id
  loadbalancer_id                = azurerm_lb.lb_app.id
}

# resource "azurerm_network_interface_backend_address_pool_association" "lb_app_nic_association" {
#   for_each                = var.vmlinux_app_instance_count
#   network_interface_id    = azurerm_network_interface.vmlinux_appsub_nic[each.key].id
#   ip_configuration_name   = azurerm_network_interface.vmlinux_appsub_nic[each.key].ip_configuration[0].name
#   backend_address_pool_id = azurerm_lb_backend_address_pool.lb_app_backend_address_pool.id
# }