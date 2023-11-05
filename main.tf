module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  name                = var.vnet_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = var.vnet_address_space
}

module "subnet_internal" {
  source               = "./modules/subnet"
  name                 = var.subnet_internal_name
  virtual_network_name = module.vnet.vnet_name
  resource_group_name  = module.resource_group.resource_group_name
  address_prefixes     = var.address_prefixes
}

module "k8s_cluster" {
  source              = "./modules/kubernetes_cluster"
  k8s_cluster_name    = var.k8s_cluster_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  dns_prefix          = var.dns_prefix

  node_count = var.node_count
  vm_size    = var.vm_size

  gateway_subnet_id = module.subnet_internal.Subnet_id
  gateway_name      = var.gateway_name

  node_pool_name    = var.node_pool_name
  node_pool_vm_size = var.node_pool_vm_size
  node_pool_count   = var.node_pool_count
  vnet_subnet_id    = module.subnet_internal.Subnet_id
}
