# terraform {
#   required_providers {
#     azurerm = {
#       source                = "hashicorp/azurerm"
#       version               = "~>3.0"
#       configuration_aliases = [azurerm]
#     }
#   }
# }


# resource "azurerm_public_ip" "pip" {
#   name                = var.public_ip_name
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   allocation_method   = var.allocation_method
#   sku                 = var.sku
# }


resource "azurerm_public_ip" "public_ip" {
  count               = length(var.public_ip_name)
  name                = var.public_ip_name[count.index]
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
}
