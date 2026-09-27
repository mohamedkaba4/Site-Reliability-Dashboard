resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_user_assigned_identity" "aks" {
  name                = "id-${var.aks_cluster_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.aks.name
  tags                = var.tags
}

resource "azurerm_role_assignment" "aks_subnet_network_contributor" {
  scope                = data.azurerm_subnet.aks.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = azurerm_resource_group.aks.name

  dns_prefix         = "sre-dashboard-prod"
  kubernetes_version = var.kubernetes_version

  sku_tier = "Standard"

  private_cluster_enabled = true
  local_account_disabled  = true

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  role_based_access_control_enabled = true

  azure_active_directory_role_based_access_control {
    tenant_id          = data.azurerm_client_config.current.tenant_id
    azure_rbac_enabled = true
  }

  automatic_upgrade_channel = "patch"
  node_os_upgrade_channel   = "NodeImage"

  default_node_pool {
    name                        = "system"
    temporary_name_for_rotation = "systemtmp"

    vm_size        = var.system_node_vm_size
    type           = "VirtualMachineScaleSets"
    vnet_subnet_id = data.azurerm_subnet.aks.id

    auto_scaling_enabled = true
    min_count            = var.system_node_min_count
    max_count            = var.system_node_max_count

    zones = ["1", "2", "3"]
  }

  identity {
    type = "UserAssigned"

    identity_ids = [
      azurerm_user_assigned_identity.aks.id
    ]
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"

    service_cidr   = "10.21.0.0/16"
    dns_service_ip = "10.21.0.10"
    pod_cidr       = "10.244.0.0/16"

    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  tags = var.tags

  depends_on = [
    azurerm_role_assignment.aks_subnet_network_contributor
  ]
}
