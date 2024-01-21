# Declare variables

variable "location" {}
variable "resource_group_name" {}
variable "virtual_network_name" {}

variable "address_space" {
  type = list(string)
}


#variable "AWS_ACCESS_KEY" {}
#variable "AWS_SECRET_KEY" {}
#variable "AWS_SESSION_TOKEN" {}
#variable "DEFAULT_REGION" {}
  