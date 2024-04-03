variable "ip_groups" {
  type = list(object({
    name                = string
    resource_group_name = string
    location            = string
    cidrs               = list(string)
  }))
}


variable "include_module" {
  description = "Whether to include the module or not"
  type        = bool
  default     = false
}
