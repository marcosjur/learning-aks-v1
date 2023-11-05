variable "resource_group_name" {
  type        = string
  description = "The resource group name"
}

variable "location" {
  type        = string
  description = "Locations"
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Virtual network address spaces"
}

variable "address_prefixes" {
  type = list(string)
}

variable "subnet_internal_name" {
  type = string
}

variable "k8s_cluster_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "node_count" {
  type = number
}

variable "vm_size" {
  type = string
}

variable "node_pool_name" {
  type = string
}

variable "node_pool_vm_size" {
  type = string
}

variable "node_pool_count" {
  type = string
}

variable "gateway_name" {
  type = string
}