output "loki_client_id" {
  value = azurerm_user_assigned_identity.loki.client_id
}

output "loki_storage_account_name" {
  value = azurerm_storage_account.loki.name
}
