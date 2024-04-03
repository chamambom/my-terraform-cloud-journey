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
  count    = var.include_module ? 1 : 0
  for_each = { for idx, ip_group in var.ip_groups : idx => ip_group }

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  cidrs               = each.value.cidrs

}

# ipgroup = [
#   { name = "NPS_Radius_Servers_1", resource_group_name = "werwerwrwrwerwrw", location = "australiaeast", cidrs = ["10.210.6.0/28"] },
#   { name = "NPS_Radius_Servers_2", resource_group_name = "ddfgdgfdgfdgfdgd", location = "australiaeast", cidrs = ["10.210.6.0/28"] },
# ]


