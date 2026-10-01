output "loki_client_id" {
  description = "Client ID of the Loki user-assigned managed identity."
  value       = azurerm_user_assigned_identity.loki.client_id
}

output "loki_principal_id" {
  description = "Principal ID of the Loki user-assigned managed identity."
  value       = azurerm_user_assigned_identity.loki.principal_id
}

output "loki_storage_account_name" {
  description = "Azure Storage account used by Loki."
  value       = azurerm_storage_account.loki.name
}

output "loki_storage_account_id" {
  description = "Resource ID of the Azure Storage account used by Loki."
  value       = azurerm_storage_account.loki.id
}
