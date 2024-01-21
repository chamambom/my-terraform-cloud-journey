# Create a Remote Backend
terraform {
  backend "azurerm" {
    # storage_account_name needs to be changed manually as variables are not supported.
    # Should be a format like "<random chars>terraform", eg: "am1ojbxsfterraform"
    storage_account_name = "asw026kcuterra"
    container_name       = "terra-iac-state"
    key                  = "terraform.tfstate" #name of the state file

    #access_key provided via ARM_ACCESS_KEY env var
  }
}


# 2. Configure the AzureRM Provider
provider "azurerm" {
  # The AzureRM Provider supports authenticating using via the Azure CLI, a Managed Identity
  # and a Service Principal. More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure

  # The features block allows changing the behaviour of the Azure Provider, more
  # information can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
  features {}
}

# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  # tags {
  #   environment = "test"
  # }
}


#Create virtual network

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}



