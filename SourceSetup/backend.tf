terraform {
  backend "azurerm" {
    resource_group_name = "CommonHOSRCMtfBackend-RG"
    storage_account_name = "commontfbackend427371"
    container_name       = "tfstate"
    key                  = "source.terraform.tfstate"
  }
}
