# Resource Groups Virtual-WAN - Region 1
resource "azurerm_resource_group" "region1-rg1" {
  name     = "generalnonprd01-nprd-iaasmgmt-ae-rg"
  location = var.region1
  tags = {
    Environment = var.environment_tag
    Function    = "Virtual-WAN-AE-ResourceGroups"
  }
}
# Resource Groups Virtual-WAN - Region 2
resource "azurerm_resource_group" "region2-rg1" {
  name     = "generalnonprd01-nprd-iaasmgmt-ase-rg"
  location = var.region2
  tags = {
    Environment = var.environment_tag
    Function    = "Virtual-WAN-ASE-ResourceGroups"
  }
}
