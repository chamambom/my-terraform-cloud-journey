terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}


# Azure Virtual Network Gateway Connection to Express Route
resource azurerm_virtual_network_gateway_connection "virtual_network_gateway_connection" {
    name                             = var.connection_name
    location                         = var.region
    resource_group_name              = var.resource_group_name
    type                             = var.connection_type
    virtual_network_gateway_id       = var.virtual_network_gateway_id
    express_route_circuit_id         = var.express_route_circuit_id
    routing_weight                   = var.routing_weight
    authorization_key                = var.authorization_key                                 
}
