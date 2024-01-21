#Terraform module main.tf file
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.86.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "resource_group" {
  source    = "./modules/resource_group"
  base_name = "nzpost-"
  location  = "West US"
}

module "storage_account" {
  source              = "./modules/storage_account"
  base_name           = "nzpost"
  resource_group_name = module.resource_group.rg_name_out
  location            = "West US"
  depends_on = [
    module.resource_group
  ]
}

module "virtual_network" {
  source              = "./modules/virtual_network"
  name                = "test_vnet"
  resource_group_name = module.resource_group.rg_name_out
  location            = module.resource_group.location_out
  address_space       = ["10.1.0.0/16"]
  depends_on = [
    module.resource_group
  ]
}

module "subnet" {
  source               = "./modules/subnet"
  for_each             = var.subnets
  name                 = each.value.name
  virtual_network_name = module.virtual_network.vnet_name
  resource_group_name  = module.resource_group.rg_name_out
  address_prefixes     = each.value.address_prefixes
  depends_on = [
    module.virtual_network
  ]
}


