terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}


# locals {
#   default_tags = {}
#   all_tags     = merge(local.default_tags, var.az_tags)
# }

# Resource Group

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_location

  # tags = local.all_tags
}
