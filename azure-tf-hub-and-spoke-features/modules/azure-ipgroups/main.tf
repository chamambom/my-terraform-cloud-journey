terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}


resource "azurerm_ip_group" "tpk_ipgroups" {
  name                = var.ip_group_name
  location            =  var.location
  resource_group_name = var.resource_group_name
  cidrs = var.cidr_blocks

}
