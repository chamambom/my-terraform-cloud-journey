variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "ip_group_name" {
  type = string
}

variable "cidr_blocks" {
   type    = list(string)
}