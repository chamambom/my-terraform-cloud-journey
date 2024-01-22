# variable "public_ip_name" {
#   type        = string
#   description = "The full Azure resource ID of the remote virtual network."
# }

# variable "resource_group_name" {
#   type        = string
#   description = "The name of the resource group in which to create the virtual network peering."
# }

# variable "location" {
#   type = string
# }

# variable "allocation_method" {
#   type        = string
#   description = "The full Azure resource ID of the remote virtual network."
# }

# variable "sku" {
#   type        = string
#   description = "The full Azure resource ID of the remote virtual network."
# }


variable "public_ip_name" {
  type        = list(string)
  description = "(Required) Specifies the name of the Public IP resource"
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the public ip"
}

variable "allocation_method" {
  type        = string
  description = "(Required) Defines the allocation method for this IP address.Possible values are Static or Dynamic"
  default     = "Dynamic"
}

variable "sku" {
  type        = string
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  default     = "Basic"
}

