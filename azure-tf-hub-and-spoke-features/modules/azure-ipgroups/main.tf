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
  name                = var.ip_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
  cidrs               = var.cidr_blocks

}


resource "azurerm_ip_group" "tpk_ipgroups" {
  name                = var.ip_group_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "cidrs" {
    for_each = var.routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = lookup(route.value, "next_hop_in_ip_address", null)
    }
  }
}
