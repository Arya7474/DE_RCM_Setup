resource "azurerm_user_assigned_identity" "example" {
  location            = azurerm_resource_group.example.location
  name                = var.sourceuserassignedmid
  resource_group_name = azurerm_resource_group.example.name
  tags = {
    environment=var.env
  }
}

resource "azurerm_data_factory" "example" {
  name                = var.adfname
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  github_configuration {
    account_name = local.account_name
    branch_name = local.branch_name
    git_url = local.git_url
    repository_name = local.repository_name
    root_folder = local.root_folder
  }
  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }
  tags = {
    environment=var.env
  }
}









# https://adf.azure.com/en-us/home?factoryName=HOSRCMSOURCEADF4321&resourceGroupName=HOSRCMSOURCE&subscriptionId=568af9f1-d4cc-43fa-b121-2fdc3c3953a0&liveMode=true

