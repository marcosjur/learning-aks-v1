variable "name" {
  type        = string
  description = "Subnet name"
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual Network connection"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "address_prefixes" {
  type        = list(string)
  description = "Address prefixes"
}