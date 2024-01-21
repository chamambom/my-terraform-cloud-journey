data "azurerm_virtual_network" "initiator" {
  provider = azurerm.Connectivity-Subscription

  name                = var.peerings["source"]["vnet"]
  resource_group_name = var.peerings["source"]["resource_group"]
}

data "azurerm_virtual_network" "target" {
  provider = azurerm.Management-Subscription

  name                = var.peerings["target"]["vnet"]
  resource_group_name = var.peerings["target"]["resource_group"]
}
