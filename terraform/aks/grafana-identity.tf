resource "azurerm_user_assigned_identity" "grafana" {
  name                = "id-sre-grafana-prod"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
}

resource "azurerm_federated_identity_credential" "grafana" {
  name = "fic-sre-grafana-prod"

  user_assigned_identity_id = azurerm_user_assigned_identity.grafana.id

  audience = [
    "api://AzureADTokenExchange"
  ]

  issuer  = azurerm_kubernetes_cluster.main.oidc_issuer_url
  subject = "system:serviceaccount:observability:sre-monitoring-grafana"
}

resource "azurerm_role_assignment" "grafana_management_reader" {
  scope                = "/subscriptions/59b3a0c1-d71e-452f-9950-e28743627a30"
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.grafana.principal_id
}

resource "azurerm_role_assignment" "grafana_prod_reader" {
  scope                = "/subscriptions/2df97227-9b74-448e-8bc9-aa5cb23994ba"
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.grafana.principal_id
}
