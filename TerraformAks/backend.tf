terraform {
  backend "azurerm" {
    resource_group_name  = "robot-rg"
    storage_account_name = "azurebackendblob2025"
    container_name       = "tfstate"
    key                  = "aks-cluster.terraform.tfstate"
  }
}
