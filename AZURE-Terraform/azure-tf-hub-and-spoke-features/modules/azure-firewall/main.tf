# terraform {
#   required_providers {
#     azurerm = {
#       source                = "hashicorp/azurerm"
#       version               = "~>3.0"
#       configuration_aliases = [azurerm]
#     }
#   }
# }


resource "azurerm_firewall" "az-firewall" {
  name                = var.azure_firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  # Associating Azure Firewall with Firewall Manager Policy
  firewall_policy_id = azurerm_firewall_policy.az-firewall-pol01.id

  ip_configuration {
    name                 = var.ipconfig_name
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
}

#Firewall Policy
resource "azurerm_firewall_policy" "az-firewall-pol01" {
  count               = var.include_module ? 1 : 0
  name                = var.azure_firewall_policy_name
  location            = var.location
  resource_group_name = var.resource_group_name

}
