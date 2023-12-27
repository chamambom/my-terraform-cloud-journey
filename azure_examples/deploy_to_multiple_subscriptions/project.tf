# # * * * * * * *  module resource_groups is used to build Resource Groups [Primary and Secondary] * * * * * * *
module "resource_groups" {
  source   = "./modules/resource_groups"
  location = var.location
}

# # * * * * * * *  module virtual_networks is used for creating vnets in each Resource Group * * * * * * *
# module "virtual_networks" {
#   source                = "./modules/virtual_networks"
#   location              = var.location
#   environment           = var.environment
#   rg-test-name          = module.resource_groups.rg-test-name
#   vnet1-address-space   = var.vnet1-address-space
#   vnet1-subnet1-address = var.vnet1-subnet1-address
#   depends_on            = [module.resource_groups]
# }


module "rg-connectivity" {
  source   = "./modules/resource_groups"
  provider = azurerm.Aroturuki-Connectivity
  name = "rg-connectivity-001"
}

module "rg-management" {
  source = "./modules/resource_groups"
  # providers = {
  #   azurerm = azurerm.prod
  # }
  provider = azurerm.Aroturuki-Management
  name = "rg-management-001"
}

# module "vneta-to-vnetb" {
#   source = "./modules/vnet_peering"

#   local_vnet_name             = module.vneta.vnet_name
#   local_rg_name               = module.vneta.networking_resource_group_name
#   remote_vnet_name            = module.vneta.vnet_name
#   remote_vnet_id              = module.vnetb.vnet_id
#   allow_vnet_access           = "true"
#   allow_forwarded_traffic     = "true"
#   allow_allow_gateway_transit = "false"
#   use_use_remote_gateways     = "false"
# }
