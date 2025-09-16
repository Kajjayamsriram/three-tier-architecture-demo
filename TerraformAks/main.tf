provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "aks_rg" {
  name = "robot-rg"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_name
  location            = data.azurerm_resource_group.aks_rg.location
  resource_group_name = data.azurerm_resource_group.aks_rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.agent_count
    vm_size    = var.vm_size
  }
  
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }

  linux_profile {
  admin_username = "azureuser"

  ssh_key {
    key_data = file(var.ssh_public_key_path)
  }
}

}
