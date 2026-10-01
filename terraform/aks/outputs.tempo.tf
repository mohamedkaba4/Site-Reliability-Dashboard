output "tempo_client_id" {
  description = "Client ID of the Tempo managed identity."
  value       = azurerm_user_assigned_identity.tempo.client_id
}

output "tempo_storage_account_name" {
  description = "Azure Storage account used by Tempo."
  value       = azurerm_storage_account.tempo.name
}
