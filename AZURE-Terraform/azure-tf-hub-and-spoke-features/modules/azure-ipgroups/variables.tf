# variable "location" {
#   type = string
# }

# variable "resource_group_name" {
#   type = string
# }

# variable "ip_group_name" {
#   type = string
# }

# variable "cidr_blocks" {
#   type = list(string)
# }

variable "ipgroups" {
  type = map(object({
    name                = string
    location            = string
    cidrs               = list(string)
    resource_group_name = string
  }))
}

