resource "azurerm_resource_group" "example" {
  name     = var.rgname
  location = var.devrgloc
}

resource "azurerm_storage_account" "example" {
  name                     = var.adls
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  is_hns_enabled = true

  tags = {
    environment = var.devenv
  }
}

resource "azurerm_storage_container" "example" {
    for_each = var.containernames
  name                  = each.key
  storage_account_name = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "tab-projects" {
  for_each = var.claimsdatafiles
  name                   = each.key
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example["landing"].name
  type                   = "Block"
  source                 = each.value
}

