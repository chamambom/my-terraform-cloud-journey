terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}


resource "azurerm_network_ddos_protection_plan" "module" {
  name                = var.ddos_plan_name
  location            = var.ddos_plan_location
  resource_group_name = var.rg_name

  # tags = var.ddos_plan_tags
}

