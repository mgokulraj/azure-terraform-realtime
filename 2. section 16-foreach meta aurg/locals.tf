locals {
  owners               = var.business
  environment          = var.environment
  resource_name_prefix = "${var.business}-${var.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}