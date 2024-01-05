resource "azurerm_storage_account" "storage_account" {
  name = "${var.storage_account_name}${random_string.myrandom}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
account_tier = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind = var.storage_account_kind

  static_website {
    index_document = var.static_website_index_document
    error_404_document = var.static_website_error_404_document
  }
}

resource "azurerm_storage_container" "httpd_files_container" {
  name = "httpd-files-container"
  storage_account_name = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}