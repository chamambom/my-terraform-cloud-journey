# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#   Resource Groups's Virtual Netowrk and LinuxVM
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
# Create a VNet

resource "azurerm_virtual_network" "tf-vnetwork-01" {
  name                = "tf-vnetwork-01"
  location            = var.location
  resource_group_name = var.rg-test-name
  address_space       = var.vnet1-address-space
}

resource "azurerm_virtual_network_peering" "initiator_to_target" {
  provider = azurerm.Aroturuki-Connectivity

  name                         = var.peerings["source"]["name"]
  resource_group_name          = var.peerings["source"]["resource_group"]
  virtual_network_name         = var.peerings["source"]["vnet"]
  remote_virtual_network_id    = data.azurerm_virtual_network.target.id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
}

resource "azurerm_virtual_network_peering" "target_to_initiator" {
  provider = azurerm.Aroturuki-Management

  name                         = var.peerings["target"]["name"]
  resource_group_name          = var.peerings["target"]["resource_group"]
  virtual_network_name         = var.peerings["target"]["vnet"]
  remote_virtual_network_id    = data.azurerm_virtual_network.initiator.id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
}


#Create a Subnet
resource "azurerm_subnet" "vnet1-subnet1" {
  name                 = "vnet1-subnet1"
  resource_group_name  = var.rg-test-name
  virtual_network_name = azurerm_virtual_network.tf-vnetwork-01.name
  address_prefixes     = var.vnet1-subnet1-address
}



