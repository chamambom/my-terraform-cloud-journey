#main.tf - for_each example
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example_rg" {
  for_each = var.rgs
  name     = each.value["name"]     #each.value.name
  location = each.value["location"] #each.value.location
  tags     = each.value["tags"]     #each.value.tags
}

#variable.tf - for_each example
variable "rgs" {
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
  default = {
    "first" = {
      name     = "first_rg"
      location = "west us"
      tags = {
        "owner"    = "vcloud-lab.com"
        "downtime" = "afternoon"
      }
    }
    "second" = {
      name     = "second_rg"
      location = "east us"
      tags = {
        "owner"    = "vJanvi"
        "downtime" = "morning"
      }
    }
  }
}
