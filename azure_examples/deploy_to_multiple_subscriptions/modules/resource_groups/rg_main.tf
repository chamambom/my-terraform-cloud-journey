# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   Resource Group
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.name
}