resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.k8s_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name           = "system"
    node_count     = var.node_count
    vm_size        = var.vm_size
    vnet_subnet_id = var.vnet_subnet_id
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }

  private_cluster_enabled = true

  ingress_application_gateway {
    subnet_id    = var.gateway_subnet_id
    gateway_name = var.gateway_name
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = var.node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.node_pool_vm_size
  node_count            = var.node_pool_count
  vnet_subnet_id        = var.vnet_subnet_id

}