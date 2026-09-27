data "azurerm_subnet" "aks" {
  name                 = var.aks_subnet_name
  virtual_network_name = var.observability_vnet_name
  resource_group_name  = var.observability_network_resource_group
}

data "azurerm_client_config" "current" {}
