variable "subscription_id" {
  description = "Azure subscription hosting the observability platform."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group hosting the AKS control-plane resource."
  type        = string
}

variable "aks_cluster_name" {
  description = "AKS cluster name."
  type        = string
}

variable "kubernetes_version" {
  description = "Approved Kubernetes minor version."
  type        = string
}

variable "observability_network_resource_group" {
  description = "ALZ-managed resource group containing the observability VNet."
  type        = string
}

variable "observability_vnet_name" {
  description = "ALZ-managed observability spoke VNet."
  type        = string
}

variable "aks_subnet_name" {
  description = "ALZ-managed subnet dedicated to AKS."
  type        = string
}

variable "system_node_vm_size" {
  description = "VM SKU for the AKS system node pool."
  type        = string
}

variable "system_node_min_count" {
  description = "Minimum system node count."
  type        = number
}

variable "system_node_max_count" {
  description = "Maximum system node count."
  type        = number
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}

variable "aks_admin_group_object_id" {
  description = "Microsoft Entra group granted AKS RBAC Cluster Admin access."
  type        = string
}
