
#Azure virtual network module variable.tf file
variable "name" {
  type    = string
}

variable "resource_group_name" {
  type    = string
}

variable "location" {
  type    = string
}

variable "address_space" {
  type    = list(any)
  default = ["10.0.0.0/16"]
}