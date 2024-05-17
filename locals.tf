locals {
  owners                = var.business
  environment           = var.environment
  resource_name_prefix  = "${var.location}-${var.business}-${var.environment}"
  source_address_prefix = var.source_address_prefix
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}