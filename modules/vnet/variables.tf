variable "name" {
  type        = string
  description = "Virtual Network name"
}

variable "location" {
  type        = string
  description = "Virtual Network location"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "address_space" {
  type        = list(string)
  description = "Vnet network space"
}