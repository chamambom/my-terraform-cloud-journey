#main.tf - After adding dynamic block
provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "demo" {
    name     = var.rg_name
    location = var.location
}

resource "azurerm_network_security_group" "vcloud-lab" {
    name                = var.nsg_name
    location            = azurerm_resource_group.demo.location
    resource_group_name = azurerm_resource_group.demo.name

    dynamic "security_rule" {
        for_each = var.sec_rules
        content {
            name                       = security_rule.value["name"]
            priority                   = security_rule.value["priority"]
            direction                  = security_rule.value["direction"]
            access                     = security_rule.value["access"]
            protocol                   = security_rule.value["protocol"]
            source_port_range          = security_rule.value["source_port_range"]
            destination_port_range     = security_rule.value["destination_port_range"]
            source_address_prefix      = "*"
            destination_address_prefix = "*"
        }
    }

    tags = {
        environment = "dev"
        owner = "vcloud-lab.com"
    }
}

#variable.tf - After adding dynamic block
variable "rg_name" {
  type = string
  default = "RG_vloud-lab"
}

variable "location" {
  type = string
  default = "West Us"
}

variable "nsg_name" {
  type = string
  default = "NSG_vCloud-lab"
}

variable "sec_rules" {
    description = "NSG security rules"
    type = list(object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string
    }))
    default = [{
        name                       = "Rule01"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "80"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    },
    {
        name                       = "Rule02"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "443"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }]
}