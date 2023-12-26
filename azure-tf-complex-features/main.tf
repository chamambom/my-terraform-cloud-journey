####################################################################################
#              Resource Group Module is Used to Create Resource Groups            
####################################################################################
module "desktop-resourcegroup" {
  source = "./modules/resourcegroups"
  # Resource Group Variables
  az_rg_name     = "rg-fme-prd-ae-001"
  az_rg_location = "australiaeast"
  
  # providers = {
  #   azurerm = azurerm.prod
  # }
}

####################################################################################
#              virtual network Module is Used to vnets and subnets            
####################################################################################





####################################################################################
#              Route table Module is Used to route tables            
####################################################################################


module "route_table_print" {
  source              = "./modules/azurerm-route-table"
  name                = "rt-print-afwroute-001"
  resource_group_name = data.azurerm_subnet.print.resource_group_name
  location            = "australiaeast"
  routes = [
    { name = "ToFortigateFirewall", address_prefix = "0.0.0.0/0", next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.50.0.68" }
  ]
  disable_bgp_route_propagation = true

  subnet_ids = [data.azurerm_subnet.print.id]

  #   providers = {
  #   azurerm = azurerm.prod
  # }
}


module "route_table_adds_enterprise_networks" {
  source              = "./modules/azurerm-route-table"
  name                = "rt-aadds-afwroute-001"
  resource_group_name = data.azurerm_subnet.aadds.resource_group_name
  location            = "australiaeast"
  routes = [
    { name = "ToFortigateFirewall", address_prefix = "10.0.0.0/8", next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.50.0.68" },
    { name = "WANA", address_prefix = "59.153.21.0/24", next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.50.0.68" },
    { name = "WANB", address_prefix = "202.49.24.0/23", next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.50.0.68" },
    { name = "WANC", address_prefix = "202.49.26.0/24", next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.50.0.68" }
  ]
  disable_bgp_route_propagation = true

  subnet_ids = [data.azurerm_subnet.aadds.id, data.azurerm_subnet.pdns-resolver-inbound.id, data.azurerm_subnet.pdns-resolver-outbound.id ]

  #   providers = {
  #   azurerm = azurerm.shared
  # }
}
