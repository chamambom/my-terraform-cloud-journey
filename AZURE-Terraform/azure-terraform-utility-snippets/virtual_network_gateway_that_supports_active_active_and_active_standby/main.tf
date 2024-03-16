
######################################### Begin Implementing HUB VNET Resources ####################################

# Resource Group Module is Used to Create Resource Groups
module "hub-resourcegroup" {
  source = "./modules/resourcegroups"
  # Resource Group Variables
  az_rg_name     = "rg-connectivity-hub-01"
  az_rg_location = "australiaeast"
  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}


# vnet Module is used to create Virtual Networks and Subnets
module "hub-vnet" {
  source = "./modules/vnet"

  virtual_network_name          = "vnet-connecitivty-hub-prod-01"
  resource_group_name           = module.hub-resourcegroup.rg_name
  location                      = module.hub-resourcegroup.rg_location
  virtual_network_address_space = ["10.210.0.0/24"]

  # Subnets are used in Index for other modules to refer
  # module.hub-vnet.vnet_subnet_id[0] = ApplicationGatewaySubnet   
  # module.hub-vnet.vnet_subnet_id[1] = AzureBastionSubnet         
  # module.hub-vnet.vnet_subnet_id[2] = AzureFirewallSubnet        
  # module.hub-vnet.vnet_subnet_id[3] = GatewaySubnet              
  # module.hub-vnet.vnet_subnet_id[4] = JumpboxSubnet       

  subnet_names = {
    "GatewaySubnet" = {
      subnet_name      = "GatewaySubnet"
      address_prefixes = ["10.210.0.96/27"]
      route_table_name = ""
      snet_delegation  = ""
    },
    "AzureFirewallSubnet" = {
      subnet_name      = "AzureFirewallSubnet"
      address_prefixes = ["10.210.0.0/26"]
      route_table_name = ""
      snet_delegation  = ""
    },
    "ApplicationGatewaySubnet" = {
      subnet_name      = "ApplicationGatewaySubnet"
      address_prefixes = ["10.210.0.128/27"]
      route_table_name = ""
      snet_delegation  = ""
    }
    "AzureBastionSubnet" = {
      subnet_name      = "AzureBastionSubnet"
      address_prefixes = ["10.210.0.64/27"]
      route_table_name = ""
      snet_delegation  = ""
    }
  }

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}




#########################################Begin Implementing Azure Firewall ####################################


# publicip Module is used to create Public IP Address
module "public_ip_03" {
  source = "./modules/publicip"

  # Used for Azure Firewall 
  public_ip_name      = "pip-afw-connectivity-hub-01"
  resource_group_name = module.hub-resourcegroup.rg_name
  location            = module.hub-resourcegroup.rg_location
  allocation_method   = "Static"
  sku                 = "Standard"

  # providers = {
  #   azurerm = azurerm.connectivity
  # }

}


# azurefirewall Module is used to create Azure Firewall 
# Firewall Policy
# Associate Firewall Policy with Azure Firewall
# Network and Application Firewall Rules 
module "azure_firewall_01" {
  source     = "./modules/azurefirewall"
  depends_on = [module.hub-vnet]

  azure_firewall_name = "afw-connectivity-hub-01"
  location            = module.hub-resourcegroup.rg_location
  resource_group_name = module.hub-resourcegroup.rg_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ipconfig_name        = "configuration"
  subnet_id            = module.hub-vnet.vnet_subnet_id[2]
  public_ip_address_id = module.public_ip_03.public_ip_address_id

  azure_firewall_policy_name = "afwpolicy-tpk-ae-001"



  # providers = {
  #   azurerm = azurerm.connectivity
  # }

}




#########################################Begin Implementing Azure VPN Gateway####################################

# publicip Module is used to create Public IP Address
module "public_ip_01" {
  source = "./modules/publicip"

  # Used for VPN Gateway 
  public_ip_name      = "pip-connectivity-hub-02"
  resource_group_name = module.hub-resourcegroup.rg_name
  location            = module.hub-resourcegroup.rg_location
  allocation_method   = "Static"
  sku                 = "Standard"

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}
# publicip Module is used to create Public IP Address
module "public_ip_05" {
  source = "./modules/publicip"

  # Used for VPN Gateway 
  public_ip_name      = "pip-connectivity-hub-04"
  resource_group_name = module.hub-resourcegroup.rg_name
  location            = module.hub-resourcegroup.rg_location
  allocation_method   = "Static"
  sku                 = "Standard"

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}

# publicip Module is used to create Public IP Address
module "public_ip_06" {
  source = "./modules/publicip"

  # Used for VPN Gateway 
  public_ip_name      = "pip-expressroute-east"
  resource_group_name = module.hub-resourcegroup.rg_name
  location            = module.hub-resourcegroup.rg_location
  allocation_method   = "Static"
  sku                 = "Standard"

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}

# vpn-gateway Module is used to create a VPN Gateway
module "vpn_gateway" {
  include_bgp_settings = true
  gateway_type          = "active-active"

  source     = "./modules/vpn-gateway"
  depends_on = [module.hub-vnet, module.azure_firewall_01]

  vpn_gateway_name    = "vpn-connectivity-hub-01"
  location            = module.hub-resourcegroup.rg_location
  resource_group_name = module.hub-resourcegroup.rg_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  sku           = "VpnGw2"
  active_active = true
  enable_bgp    = true
  
  
  private_ip_address_allocation = "Dynamic"
  subnet_id                     = module.hub-vnet.vnet_subnet_id[3]
  public_ip_address_id          = module.public_ip_01.public_ip_address_id
  public_ip_address_id_2        = module.public_ip_05.public_ip_address_id

  # providers = {
  #   azurerm = azurerm.connectivity
  # }

}

# vpn-gateway Module is used to create a VPN Gateway
module "expressroute_gateway" {
  source     = "./modules/vpn-gateway"
  depends_on = [module.hub-vnet, module.azure_firewall_01]
  vpn_gateway_name    = "vpn-expressroute-001"
  location            = module.hub-resourcegroup.rg_location
  resource_group_name = module.hub-resourcegroup.rg_name

  type     = "ExpressRoute"
  vpn_type = "RouteBased"

  sku           = "ErGw1AZ"
  active_active = false
  enable_bgp    = false
  virtual_wan_traffic_enabled = true
  remote_vnet_traffic_enabled = true
  
  private_ip_address_allocation = "Dynamic"
  subnet_id                     = module.hub-vnet.vnet_subnet_id[3]
  public_ip_address_id          = module.public_ip_06.public_ip_address_id

  # providers = {
  #   azurerm = azurerm.connectivity
  # }

}

data "azurerm_express_route_circuit" "expressroute_wlg" {
  # provider = azurerm.root
  resource_group_name = "TPK_Network"
  name                = "ExpressRoute_WLG"
}



# 
module "expressroute_gateway_connection" {
  source     = "./modules/vpn-gateway-connection"

  connection_name = "exp-austeast-001"
  region = module.hub-resourcegroup.rg_location
  resource_group_name = module.hub-resourcegroup.rg_name

  connection_type = "ExpressRoute"
  virtual_network_gateway_id        = module.expressroute_gateway.virtual_network_gateway_id_out
  express_route_circuit_id          = data.azurerm_express_route_circuit.expressroute_wlg.id
  routing_weight                    = "10"
  authorization_key                 = "1df5fe04-b940-4442-9144-84637aff0994"


  # providers = {
  #   azurerm = azurerm.connectivity
  # }

}






