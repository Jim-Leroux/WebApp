variable "azure_subscription_id" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}

provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}

resource "azurerm_resource_group" "rg_webapp" {
  name     = "rg-webapp"
  location = "France Central"
}

resource "azurerm_kubernetes_cluster" "aks_webapp" {
  name                = "webapp"
  location            = azurerm_resource_group.rg_webapp.location
  resource_group_name = azurerm_resource_group.rg_webapp.name
  dns_prefix          = "webapp"

  default_node_pool {
    name       = "nodepool1"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "aks_kube_config" {
  description = "Kubeconfig file pour se connecter au cluster AKS"
  value       = azurerm_kubernetes_cluster.aks_webapp.kube_config_raw
  sensitive   = true
  depends_on  = [azurerm_kubernetes_cluster.aks_webapp]
}


