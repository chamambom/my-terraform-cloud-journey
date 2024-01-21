terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      configuration_aliases = [azurerm.Aroturuki-Connectivity, azurerm.Aroturuki-Management]
    }
  }
}
