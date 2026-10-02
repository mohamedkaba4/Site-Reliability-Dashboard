output "grafana_identity_client_id" {
  value = azurerm_user_assigned_identity.grafana.client_id
}

output "grafana_identity_principal_id" {
  value = azurerm_user_assigned_identity.grafana.principal_id
}
