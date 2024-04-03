variable "ip_groups" {
  type = list(object({
    name                = string
    resource_group_name = string
    location            = string
    cidrs               = list(string)
  }))
}

