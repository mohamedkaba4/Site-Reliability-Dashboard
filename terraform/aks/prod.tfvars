subscription_id = "59b3a0c1-d71e-452f-9950-e28743627a30"

location            = "eastus"
resource_group_name = "rg-sre-dashboard-prod"
aks_cluster_name    = "aks-sre-dashboard-prod"
kubernetes_version  = "1.35"

# Network is owned by the Azure Landing Zone workload layer
observability_network_resource_group = "rg-network-observability"
observability_vnet_name              = "vnet-observability-eastus-001"
aks_subnet_name                      = "snet-aks-001"
aks_admin_group_object_id            = "9c6a7377-3f83-47c8-9375-9886d45ab5fa"

# Production-style system node pool
system_node_vm_size   = "Standard_D4s_v7"
system_node_min_count = 1
system_node_max_count = 3

tags = {
  environment = "prod"
  workload    = "observability"
  managed_by  = "terraform"
  platform    = "site-reliability"
}
