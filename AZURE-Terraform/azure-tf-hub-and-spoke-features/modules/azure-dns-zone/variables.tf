variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network peering."
}

variable "private_dns_zone_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network peering."

}

variable "include_module" {
  description = "Whether to include the module or not"
  type        = bool
  default     = false
}

