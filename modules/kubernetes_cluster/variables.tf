variable "k8s_cluster_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "node_count" {
  type = number
}

variable "node_pool_count" {
  type = number
}

variable "vm_size" {
  type = string
}

variable "vnet_subnet_id" {
  type = string
}

variable "node_pool_name" {
  type = string
}

variable "node_pool_vm_size" {
  type = string
}
variable "gateway_name" {
  type = string
}

variable "gateway_subnet_id" {
  type = string
}