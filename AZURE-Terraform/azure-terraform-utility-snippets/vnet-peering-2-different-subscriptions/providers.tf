terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      configuration_aliases = [azurerm.Connectivity-Subscription, azurerm.Management-Subscription]
    }
  }
}
