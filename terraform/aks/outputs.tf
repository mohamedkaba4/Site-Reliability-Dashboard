output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.main.name
}

output "aks_resource_group_name" {
  value = azurerm_resource_group.aks.name
}

output "aks_subnet_id" {
  value = data.azurerm_subnet.aks.id
}

output "aks_identity_id" {
  value = azurerm_user_assigned_identity.aks.id
}
