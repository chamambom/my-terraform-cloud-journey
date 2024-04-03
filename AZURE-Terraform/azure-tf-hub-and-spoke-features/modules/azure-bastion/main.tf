# terraform {
#   required_providers {
#     azurerm = {
#       source                = "hashicorp/azurerm"
#       version               = "~>3.0"
#       configuration_aliases = [azurerm]
#     }
#   }
# }


resource "azurerm_bastion_host" "bastion" {
  count               = var.include_module ? 1 : 0
  name                = var.bastion_host_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                 = var.ipconfig_name
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
}
