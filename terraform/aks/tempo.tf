resource "azurerm_storage_account" "tempo" {
  name                = var.tempo_storage_account_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = var.location

  account_tier             = "Standard"
  account_replication_type = "ZRS"

  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = false
  allow_nested_items_to_be_public = false

  tags = var.tags
}

resource "azurerm_storage_container" "tempo_traces" {
  name                  = "tempo-traces"
  storage_account_id    = azurerm_storage_account.tempo.id
  container_access_type = "private"
}

resource "azurerm_user_assigned_identity" "tempo" {
  name                = "id-tempo-prod"
  location            = var.location
  resource_group_name = azurerm_resource_group.aks.name

  tags = var.tags
}

resource "azurerm_role_assignment" "tempo_blob_contributor" {
  scope                = azurerm_storage_account.tempo.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.tempo.principal_id
}

resource "azurerm_federated_identity_credential" "tempo" {
  name                      = "fic-tempo-prod"
  user_assigned_identity_id = azurerm_user_assigned_identity.tempo.id

  audience = ["api://AzureADTokenExchange"]
  issuer   = azurerm_kubernetes_cluster.main.oidc_issuer_url
  subject  = "system:serviceaccount:tempo:tempo"
}
