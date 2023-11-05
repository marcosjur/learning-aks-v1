# Resource Group
resource_group_name = "rg-zbs-aks-dev"
location            = "brazilsouth"

# Virtual Network
vnet_name          = "vnet-zbs-aks-dev"
vnet_address_space = ["10.1.0.0/16"]

# Subnet Internal
address_prefixes     = ["10.1.0.0/22"]
subnet_internal_name = "snt-zbs-aks-dev"

# Cluster
k8s_cluster_name  = "k8s-zbs-aks-dev"
dns_prefix        = "dev-k8s"
node_count        = 1
vm_size           = "Standard_DS2_v2"
node_pool_vm_size = "Standard_DS2_v2"
node_pool_name    = "user"
node_pool_count   = 2
gateway_name      = "agw-zbs-aks-dev"