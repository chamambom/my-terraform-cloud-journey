# terraform {
#   required_providers {
#     azurerm = {
#       source                = "hashicorp/azurerm"
#       version               = "~>3.0"
#       configuration_aliases = [azurerm]
#     }
#   }
# }



resource "azurerm_ip_group" "tpk_ipgroups" {
  for_each = var.ipgroups

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  cidrs               = each.value.cidrs

}


# resource "azurerm_ip_group" "tpk_ipgroups" {
#   name                = var.ip_group_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   cidrs               = var.cidr_blocks

# }

# ipgroup = [
#   { name = "NPS_Radius_Servers_1", resource_group_name = "werwerwrwrwerwrw", location = "australiaeast", cidrs = ["10.210.6.0/28"] },
#   { name = "NPS_Radius_Servers_2", resource_group_name = "ddfgdgfdgfdgfdgd", location = "australiaeast", cidrs = ["10.210.6.0/28"] },
# ]

# variable "ipgroups" {
#   type        = list(map(string))
#   default     = []
#   description = "List of objects that represent the configuration of each route."
#   /*ROUTES = [{ name = "", address_prefix = "", next_hop_type = "", next_hop_in_ip_address = "" }]*/
# }

# dynamic "ipgroup" {
#     for_each = var.ipgroups
#     content {
#       name                         = ipgroup.value.name
#       location                     = ipgroup.value.address_prefix
#       resource_group_name          = ipgroup.value.next_hop_type
#       cidrs                        = ipgroup.value.next_hop_type
#     }
#   }
