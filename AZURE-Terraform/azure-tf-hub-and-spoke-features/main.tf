####################################################################################
#              Resource Group Module is Used to Create Resource Groups             # 
####################################################################################
module "workload-a-resourcegroup" {
  source = "./modules/azure-resourcegroup"
  # Resource Group Variables
  rg_name     = "rg-workload-a-prd-ae-001"
  rg_location = "australiaeast"

}


module "workload-b-resourcegroup" {
  source = "./modules/azure-resourcegroup"
  # Resource Group Variables
  rg_name     = "rg-workload-b-prd-ae-001"
  rg_location = "australiaeast"

  # providers = {
  #   azurerm = azurerm.prod
  # }
}

module "connectivity-resourcegroup" {
  source = "./modules/azure-resourcegroup"
  # Resource Group Variables
  rg_name     = "rg-shared-resources-ae-001"
  rg_location = "australiaeast"

  # providers = {
  #   azurerm = azurerm.prod
  # }
}

####################################################################################
#              virtual network Module is Used to vnets and subnets                 #
####################################################################################

module "hub-vnet" {
  source = "./modules/azure-vnet-resources"


  resource_group_name = module.connectivity-resourcegroup.rg_name
  vnetwork_name       = "vnet-connectivity-hub-ae-001"
  location            = "australiaeast"
  vnet_address_space  = ["10.210.0.0/24"]


  firewall_subnet_address_prefix = ["10.210.0.0/26"]
  gateway_subnet_address_prefix  = ["10.210.0.64/26"]
  bastion_subnet_address_prefix  = ["10.210.0.128/26"]
  create_network_watcher         = false

  # Adding Standard DDoS Plan, and custom DNS servers (Optional)
  create_ddos_plan = false

  # Multiple Subnets, Service delegation, Service Endpoints, Network security groups
  # These are default subnets with required configuration, check README.md for more details
  # NSG association to be added automatically for all subnets listed here.
  # First two address ranges from VNet Address space reserved for Gateway And Firewall Subnets.
  # ex.: For 10.1.0.0/16 address space, usable address range start from 10.1.2.0/24 for all subnets.
  # subnet name will be set as per Azure naming convention by defaut. expected value here is: <App or project name>
  # subnets = {
  #   mgnt_subnet = {
  #     subnet_name           = "snet-management"
  #     subnet_address_prefix = ["10.210.0.192/28"]

  #     delegation = {
  #       name = "testdelegation"
  #       service_delegation = {
  #         name    = "Microsoft.ContainerInstance/containerGroups"
  #         actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
  #       }
  #     }

  #     nsg_inbound_rules = [
  #       # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
  #       # To use defaults, use "" without adding any values.
  #       ["weballow", "100", "Inbound", "Allow", "Tcp", "80", "*", "0.0.0.0/0"],
  #       ["weballow1", "101", "Inbound", "Allow", "", "443", "*", ""],
  #       ["weballow2", "102", "Inbound", "Allow", "Tcp", "8080-8090", "*", ""],
  #     ]

  #     nsg_outbound_rules = [
  #       # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
  #       # To use defaults, use "" without adding any values.
  #       ["ntp_out", "103", "Outbound", "Allow", "Udp", "123", "", "0.0.0.0/0"],
  #     ]
  #   }

  #   dmz_subnet = {
  #     subnet_name           = "snet-appgateway"
  #     subnet_address_prefix = ["10.210.0.208/28"]
  #     service_endpoints     = ["Microsoft.Storage"]

  #     nsg_inbound_rules = [
  #       # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
  #       # To use defaults, use "" without adding any values.
  #       ["weballow", "200", "Inbound", "Allow", "Tcp", "80", "*", ""],
  #       ["weballow1", "201", "Inbound", "Allow", "Tcp", "443", "AzureLoadBalancer", ""],
  #       ["weballow2", "202", "Inbound", "Allow", "Tcp", "9090", "VirtualNetwork", ""],
  #     ]

  #     nsg_outbound_rules = [
  #       # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
  #       # To use defaults, use "" without adding any values.
  #     ]
  #   }

  #   pvt_subnet = {
  #     subnet_name           = "snet-pvt"
  #     subnet_address_prefix = ["10.210.0.224/28"]
  #     service_endpoints     = ["Microsoft.Storage"]
  #   }
  # }

  # Adding TAG's to your Azure resources (Required)
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}

module "spoke1-vnet" {
  source = "./modules/azure-vnet-resources"

  resource_group_name = module.workload-a-resourcegroup.rg_name
  vnetwork_name       = "vnet-spoke1-ae-001"
  location            = "australiaeast"
  vnet_address_space  = ["10.220.0.0/24"]

  # firewall_subnet_address_prefix = ["10.220.0.96/27"]
  # gateway_subnet_address_prefix  = ["10.220.0.0/26"]
  create_network_watcher = false

  # Adding Standard DDoS Plan, and custom DNS servers (Optional)
  create_ddos_plan = false

  # Multiple Subnets, Service delegation, Service Endpoints, Network security groups
  # These are default subnets with required configuration, check README.md for more details
  # NSG association to be added automatically for all subnets listed here.
  # First two address ranges from VNet Address space reserved for Gateway And Firewall Subnets.
  # ex.: For 10.1.0.0/16 address space, usable address range start from 10.1.2.0/24 for all subnets.
  # subnet name will be set as per Azure naming convention by defaut. expected value here is: <App or project name>
  subnets = {
    mgnt_subnet = {
      subnet_name           = "snet-management"
      subnet_address_prefix = ["10.220.0.96/27"]

      delegation = {
        name = "testdelegation"
        service_delegation = {
          name    = "Microsoft.ContainerInstance/containerGroups"
          actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
        }
      }

      nsg_inbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
        ["weballow", "100", "Inbound", "Allow", "Tcp", "80", "*", "0.0.0.0/0"],
        ["weballow1", "101", "Inbound", "Allow", "", "443", "*", ""],
        ["weballow2", "102", "Inbound", "Allow", "Tcp", "8080-8090", "*", ""],
      ]

      nsg_outbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
        ["ntp_out", "103", "Outbound", "Allow", "Udp", "123", "", "0.0.0.0/0"],
      ]
    }

    app_subnet = {
      subnet_name           = "snet-appgateway"
      subnet_address_prefix = ["10.220.0.64/27"]
      service_endpoints     = ["Microsoft.Storage"]

      nsg_inbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
        ["weballow", "200", "Inbound", "Allow", "Tcp", "80", "*", ""],
        ["weballow1", "201", "Inbound", "Allow", "Tcp", "443", "AzureLoadBalancer", ""],
        ["weballow2", "202", "Inbound", "Allow", "Tcp", "9090", "VirtualNetwork", ""],
      ]

      nsg_outbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
      ]
    }

    pvt_subnet = {
      subnet_name           = "snet-pvt"
      subnet_address_prefix = ["10.220.0.128/27"]
      service_endpoints     = ["Microsoft.Storage"]
    }
  }

  # Adding TAG's to your Azure resources (Required)
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}



module "spoke2-vnet" {
  source = "./modules/azure-vnet-resources"

  resource_group_name = module.workload-b-resourcegroup.rg_name
  vnetwork_name       = "vnet-spoke2-ae-001"
  location            = "australiaeast"
  vnet_address_space  = ["10.230.0.0/24"]

  create_network_watcher = false

  # Adding Standard DDoS Plan, and custom DNS servers (Optional)
  create_ddos_plan = false

  # Multiple Subnets, Service delegation, Service Endpoints, Network security groups
  # These are default subnets with required configuration, check README.md for more details
  # NSG association to be added automatically for all subnets listed here.
  # First two address ranges from VNet Address space reserved for Gateway And Firewall Subnets.
  # ex.: For 10.1.0.0/16 address space, usable address range start from 10.1.2.0/24 for all subnets.
  # subnet name will be set as per Azure naming convention by defaut. expected value here is: <App or project name>
  subnets = {
    mgnt_subnet = {
      subnet_name           = "snet-management"
      subnet_address_prefix = ["10.230.0.128/27"]

      delegation = {
        name = "testdelegation"
        service_delegation = {
          name    = "Microsoft.ContainerInstance/containerGroups"
          actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
        }
      }

      nsg_inbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
        ["weballow", "100", "Inbound", "Allow", "Tcp", "80", "*", "0.0.0.0/0"],
        ["weballow1", "101", "Inbound", "Allow", "", "443", "*", ""],
        ["weballow2", "102", "Inbound", "Allow", "Tcp", "8080-8090", "*", ""],
      ]

      nsg_outbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
        ["ntp_out", "103", "Outbound", "Allow", "Udp", "123", "", "0.0.0.0/0"],
      ]
    }

    app_subnet = {
      subnet_name           = "snet-appsubnet"
      subnet_address_prefix = ["10.230.0.64/27"]
      service_endpoints     = ["Microsoft.Storage"]

      nsg_inbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
        ["weballow", "200", "Inbound", "Allow", "Tcp", "80", "*", ""],
        ["weballow1", "201", "Inbound", "Allow", "Tcp", "443", "AzureLoadBalancer", ""],
        ["weballow2", "202", "Inbound", "Allow", "Tcp", "9090", "VirtualNetwork", ""],
      ]

      nsg_outbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
      ]
    }

    pvt_subnet = {
      subnet_name           = "snet-private"
      subnet_address_prefix = ["10.230.0.96/27"]
      service_endpoints     = ["Microsoft.Storage"]
    }
  }

  # Adding TAG's to your Azure resources (Required)
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}



####################################################################################
#              Route table Module is Used to route tables                          #
####################################################################################

module "route-table-workload-a" {
  source              = "./modules/azure-route-table"
  name                = "rt-workload-a-afwroute-001"
  resource_group_name = module.workload-a-resourcegroup.rg_name
  location            = "australiaeast"
  routes = [
    { name = "ToFortigateFirewall", address_prefix = "0.0.0.0/0", next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.50.0.68" }
  ]
  disable_bgp_route_propagation = true

  subnet_ids = module.spoke1-vnet.subnet_ids_spokes

  depends_on = [module.hub-vnet, module.spoke1-vnet, ]

  #   providers = {
  #   azurerm = azurerm.prod
  # }

}


module "route-table-workload-b" {
  source              = "./modules/azure-route-table"
  name                = "rt-workload-b-afwroute-001"
  resource_group_name = module.workload-b-resourcegroup.rg_name
  location            = "australiaeast"
  routes = [
    { name = "ToFortigateFirewall", address_prefix = "10.0.0.0/8", next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.50.0.68" },
    { name = "WANA", address_prefix = "59.153.21.0/24", next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.50.0.68" },
    { name = "WANB", address_prefix = "202.49.24.0/23", next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.50.0.68" },
    { name = "WANC", address_prefix = "202.49.26.0/24", next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.50.0.68" }
  ]

  disable_bgp_route_propagation = true

  subnet_ids = module.spoke2-vnet.subnet_ids_spokes

  depends_on = [module.hub-vnet, module.spoke2-vnet]


  #   providers = {
  #   azurerm = azurerm.shared
  # }
}

####################################################################################
#              VNET PEERING                                                        #
####################################################################################

# vnet-peering Module is used to create peering between Virtual Networks
module "hub-to-spoke1" {
  source = "./modules/azure-vnet-peering"


  virtual_network_peering_name = "vnet-hub-to-vnet-workload-a"
  resource_group_name          = module.connectivity-resourcegroup.rg_name
  virtual_network_name         = module.hub-vnet.virtual_network_name
  remote_virtual_network_id    = module.spoke1-vnet.virtual_network_id
  allow_virtual_network_access = "true"
  allow_forwarded_traffic      = "true"
  allow_gateway_transit        = "true"
  use_remote_gateways          = "false"

  # providers = {
  #   azurerm = azurerm.connectivity
  # }

}

# vnet-peering Module is used to create peering between Virtual Networks
module "spoke1-to-hub" {
  source = "./modules/azure-vnet-peering"

  virtual_network_peering_name = "vnet-workload-a-to-vnet-hub"
  resource_group_name          = module.workload-a-resourcegroup.rg_name
  virtual_network_name         = module.spoke1-vnet.virtual_network_name
  remote_virtual_network_id    = module.hub-vnet.virtual_network_id
  allow_virtual_network_access = "true"
  allow_forwarded_traffic      = "true"
  allow_gateway_transit        = "false"
  # As there is no gateway while testing - Setting to False
  #use_remote_gateways   = "true"
  use_remote_gateways = "false"


  # providers = {
  #   azurerm = azurerm.prod
  # }

}
##########################################################################################################
# Public IP Module to create Public IPs for the Hubvnet Services Such as Gateway, Bastion, VPN Gateway

#Question - What If you want to create Public IPs in other Subscriptions and Resource Groups, thats when 
#You can duplicate this module.
##########################################################################################################

module "connectivity-public-ips" {
  source              = "./modules/azure-publicip"
  allocation_method   = "Static"
  public_ip_name      = ["bastion", "gateway", "firewall"]
  sku                 = "Standard"
  location            = module.connectivity-resourcegroup.rg_location
  resource_group_name = module.connectivity-resourcegroup.rg_name

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}


####################################################################################
#              AZURE FIREWALL                                                     #
####################################################################################

# azurefirewall Module is used to create Azure Firewall 
# Firewall Policy
# Associate Firewall Policy with Azure Firewall
# Network and Application Firewall Rules 
module "azure_firewall" {
  source = "./modules/azure-firewall"

  depends_on = [module.hub-vnet]

  azure_firewall_name = "afw-connectivity-hub-01"
  location            = module.connectivity-resourcegroup.rg_location
  resource_group_name = module.connectivity-resourcegroup.rg_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ipconfig_name        = "configuration"
  subnet_id            = module.hub-vnet.subnet_ids_hub[2]
  public_ip_address_id = module.connectivity-public-ips.firewall_public_ip_id

  azure_firewall_policy_name = "afwpolicy-afritek-ae-001"

}


####################################################################################
#              IPGROUPS                                                            #
####################################################################################


# Resource Group Module is Used to Create Resource Groups
module "ipgroups-resourcegroup" {
  source = "./modules/azure-resourcegroup"
  # Resource Group Variables
  rg_name     = "rg-ipgroups-001"
  rg_location = "australiaeast"

}



# module "ip_groups" {
#   source = "./modules/azure-ipgroups"

#   ipgroups = {
#     NPS_Radius_Servers_IP_Group = {
#       name                = "NPS_Radius_Servers"
#       location            = "australiaeast"
#       cidrs               = ["10.210.6.0/28"]
#       resource_group_name = module.ipgroups-resourcegroup.rg_name
#     },
#     AD_Servers_IP_Group = {
#       name                = "AD_Servers"
#       location            = "australiaeast"
#       cidrs               = ["10.210.6.0/28"]
#       resource_group_name = module.ipgroups-resourcegroup.rg_name
#     }
#   }

#   # providers = {
#   #   azurerm = azurerm.connectivity
#   # }
# }

####################################################################################
#              AZURE FIREWALL RULES                                                #
####################################################################################
# NB - I deployed this code with the hope that I will make it better
# If you become the custodian of this codebase, you need to enhance the code by using dynamic blocks for rules to
# avoid repition of the code blocks



# When you get time, change the IP group data structure so that you can add the IP groups using this format below, instead of what we are currently using.

# Recommended format. 

# ipgroup = [
#    NPS_Radius_Servers_1 = {resource_group_name = "werwerwrwrwerwrw", location = "australiaeast", cidrs = ["10.210.6.0/28"] },
#    NPS_Radius_Servers_2 = {resource_group_name = "ddfgdgfdgfdgfdgd", location = "australiaeast", cidrs = ["10.210.6.0/28"] },
# ]

module "ip_groupA" {
  source = "./modules/azure-ipgroups"

  ip_group_name       = "NPS_Radius_Servers"
  resource_group_name = module.ipgroups-resourcegroup.rg_name
  location            = "australiaeast"
  cidr_blocks         = ["10.210.6.0/28"]

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}

module "ip_groupB" {
  source = "./modules/azure-ipgroups"

  ip_group_name       = "AOVPN_Internal_Subnet"
  resource_group_name = module.ipgroups-resourcegroup.rg_name
  location            = "australiaeast"
  cidr_blocks         = ["10.210.4.0/27"]

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}

module "ip_groupC" {
  source = "./modules/azure-ipgroups"

  ip_group_name       = "AD_Servers"
  resource_group_name = module.ipgroups-resourcegroup.rg_name
  location            = "australiaeast"
  cidr_blocks         = ["10.210.6.0/28"]

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}

module "ip_groupD" {
  source = "./modules/azure-ipgroups"

  ip_group_name       = "Workload_ase_Servers"
  resource_group_name = module.ipgroups-resourcegroup.rg_name
  location            = "australiaeast"
  cidr_blocks         = ["10.210.2.0/24"]

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}

module "ip_groupE" {
  source = "./modules/azure-ipgroups"

  ip_group_name       = "Syslog_Servers"
  resource_group_name = module.ipgroups-resourcegroup.rg_name
  location            = "australiaeast"
  cidr_blocks         = ["10.200.48.31"]

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}

module "ip_groupF" {
  source = "./modules/azure-ipgroups"

  ip_group_name       = "Test_Block_1"
  resource_group_name = module.ipgroups-resourcegroup.rg_name
  location            = "australiaeast"
  cidr_blocks         = ["10.210.0.0/16"]

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}

module "ip_groupG" {
  source = "./modules/azure-ipgroups"

  ip_group_name       = "Test_Block_2"
  resource_group_name = module.ipgroups-resourcegroup.rg_name
  location            = "australiaeast"
  cidr_blocks = [
    "10.200.0.0/16",
    "10.100.0.0/16"
  ]

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}



module "firewall-policy-global-rules" {
  source             = "./modules/azure-firewallrules"
  name               = "global-rules"
  firewall_policy_id = module.azure_firewall.azure_firewall_policy_id_out
  priority           = 100
  network_rule_collections = { //To the TPK Operations Team, this is where you add all your NETWORK rules.
    tpk-net-global-main = {
      priority = 105
      rules = {
        NPS_Radius_Servers_Outbound = { source_ip_groups = [module.ip_groupA.ip_group_id_out], destination_ip_groups = [module.ip_groupB.ip_group_id_out], protocols = ["UDP", "ICMP"], destination_ports = [1812, 1813, 1645, 1646] }
        NPS_Radius_Servers_Inbound  = { source_ip_groups = [module.ip_groupB.ip_group_id_out], destination_ip_groups = [module.ip_groupA.ip_group_id_out], protocols = ["UDP", "ICMP"], destination_ports = [1812, 1813, 1645, 1646] }
        AD_Servers_Inbound          = { source_ip_groups = [module.ip_groupB.ip_group_id_out], destination_ip_groups = [module.ip_groupC.ip_group_id_out], protocols = ["UDP", "TCP", "ICMP"], destination_ports = [389, 636, 445, 53, 3268, 3269, 88, 135, 464, 139, "49152-65535", 88] }
        AD_Servers_Outbound         = { source_ip_groups = [module.ip_groupC.ip_group_id_out], destination_ip_groups = [module.ip_groupB.ip_group_id_out], protocols = ["UDP", "TCP", "ICMP"], destination_ports = [389, 636, 445, 53, 3268, 3269, 88, 135, 464, 139, "49152-65535", 88] }
        AD_Servers_Outbound_Syslog  = { source_ip_groups = [module.ip_groupC.ip_group_id_out], destination_ip_groups = [module.ip_groupE.ip_group_id_out], protocols = ["UDP", "ICMP"], destination_ports = [514] }
        Test29Jan                   = { source_ip_groups = [module.ip_groupG.ip_group_id_out], destination_ip_groups = [module.ip_groupF.ip_group_id_out], protocols = ["Any"], destination_ports = ["*"] }
        Test2                       = { source_ip_groups = [module.ip_groupF.ip_group_id_out], destination_ip_groups = [module.ip_groupG.ip_group_id_out], protocols = ["Any"], destination_ports = ["*"] }
        test_AD_to_AOVPN            = { source_addresses = ["10.210.6.0/24"], destination_addresses = ["10.210.20.0/22"], protocols = ["Any"], destination_ports = ["*"] }
        Allow_AOVPN_to_DCs          = { source_addresses = ["10.210.20.0/22"], destination_addresses = ["10.210.6.4", "10.210.6.5", "10.200.48.104", "10.200.48.26"], protocols = ["TCP", "ICMP", "UDP"], destination_ports = [53, 445] }
      }
      tpk-net-global-blacklist = { //To the TPK Operations Team, this is where you add NETWORK rules in your blacklist - Any rules here are just placeholders, please change them accordingly.
        action   = "Deny"
        priority = 100
        rules = {
          NPS_Radius_Servers_Outbound = { source_ip_groups = [module.ip_groupA.ip_group_id_out], destination_ip_groups = [module.ip_groupB.ip_group_id_out], protocols = ["UDP", "ICMP"], destination_ports = [500] }
          NPS_Radius_Servers_Inbound  = { source_ip_groups = [module.ip_groupB.ip_group_id_out], destination_ip_groups = [module.ip_groupA.ip_group_id_out], protocols = ["UDP", "ICMP"], destination_ports = [500] }
        }
      }
    }
  }

  application_rule_collection = {
    tpk-app-global-main = { //To the TPK Operations Team, this is where you add all your APPLICATION rules.
      priority = 135
      rules = {
        Windows_Update            = { source_addresses = ["10.210.0.0/16"], destination_fqdn_tags = ["WindowsUpdate"], protocols = [{ type = "Http", port = "80" }, { type = "Https", port = "443" }] }
        SCEPman                   = { source_addresses = ["*"], destination_fqdns = ["app-scepmantpk-001.azurewebsites.net"], protocols = [{ type = "Http", port = "80" }, { type = "Https", port = "443" }] }
        Defender_Identity_Sensors = { source_addresses = ["10.210.6.4", "10.210.6.5"], destination_fqdns = ["*.atp.azure.com"], protocols = [{ type = "Http", port = "80" }, { type = "Https", port = "443" }] }
      }
    }
    tpk-app-global-blacklist = { //To the TPK Operations Team, this is where you add all your APPLICATION rules you want to block.
      action   = "Deny"
      priority = 130
      rules = {
        webcategories = { source_ip_groups = [module.ip_groupB.ip_group_id_out], web_categories = ["CriminalActivity"], protocols = [{}, { type = "Http", port = "80" }] }
      }
    }
  }
  nat_rule_collection = { //To the TPK Operations Team, this is where you add all your APPLICATION rules - The rules are just place holders, change them accordingly.
    tpk-nat-global-main = {
      priority = 100
      rules = {
        smtp-prd = { source_addresses = ["*"], destination_address = module.connectivity-public-ips.firewall_public_ip.ip_address, destination_port = 25, translated_address = "10.210.0.4", translated_port = 25 }
      }
    }
  }


  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}

# Some Notes On how Azure Firewall Structures 

# Rule collection groups can include rule collections of various types. Rule collection group priority affects the order in which rules are executed.


# You can include the block of code below if you want to attach it to a different policy ID or a Rule collection group.

# module "firewall-policy-messaging-rules" {
#   source = "./modules/firewallrules"
#   name   = "messaging-rules"
#   # firewall_policy_id = module.firewall-policy.policy_id
#   priority = 200
#   nat_rule_collection = { //To the TPK Operations Team, this is where you add all your APPLICATION rules - The rules are just place holders, change them accordingly.
#     nat-messaging = {
#       priority = 100
#       rules = {
#         smtp-prd = { source_addresses = ["*"], destination_address = "20.28.235.21", destination_port = 25, translated_address = "10.210.6.15", translated_port = 25 }
#       }
#     }
#   }

#   providers = {
#     azurerm = azurerm.connectivity
#   }

# }

####################################################################################
#              BASTION                                                     #
####################################################################################


# # bastion Module is used to create Bastion in Hub Virtual Network - To Console into Virtual Machines Securely
# module "vm-bastion" {
#   source = "./modules/azure-bastion"

#   bastion_host_name   = "bas-connectivity-hub-01"
#   resource_group_name = module.connectivity-resourcegroup.rg_name
#   location            = module.connectivity-resourcegroup.rg_location

#   ipconfig_name        = "configuration"
#   subnet_id            = module.hub-vnet.subnet_ids_hub[0]
#   public_ip_address_id = module.connectivity-public-ips.bastion_public_ip_id

#   depends_on = [module.hub-vnet, module.azure_firewall]

#   # providers = {
#   #   azurerm = azurerm.connectivity
#   # }

# }

####################################################################################
#              VPN GATEWAY                                                     #
####################################################################################

# # vpn-gateway Module is used to create Express Route Gateway - So that it can connect to the express route Circuit
# module "vpn_gateway" {
#   source     = "./modules/azure-vpn-gateway"
#   depends_on = [module.hub-vnet, module.azure_firewall]

#   vpn_gateway_name    = "vpn-connectivity-hub-01"
#   location            = module.connectivity-resourcegroup.rg_location
#   resource_group_name = module.connectivity-resourcegroup.rg_name

#   type     = "Vpn"
#   vpn_type = "RouteBased"

#   sku           = "VpnGw2"
#   active_active = false
#   enable_bgp    = false

#   ip_configuration              = "default"
#   private_ip_address_allocation = "Dynamic"
#   subnet_id                     = module.hub-vnet.subnet_ids_hub[1]
#   public_ip_address_id          = module.connectivity-public-ips.gateway_public_ip_id
#   # providers = {
#   #   azurerm = azurerm.connectivity
#   # }

# }

####################################################################################
#              Private DNS Zones                                                    #
####################################################################################

module "afritek-dnszone" {
  source                = "./modules/azure-dns-zone"
  resource_group_name   = module.connectivity-resourcegroup.rg_name
  private_dns_zone_name = "afritek.co.nz"

  # providers = {
  #   azurerm = azurerm.connectivity
  # }

}

####################################################################################
#              PRIVATE DNS RESOLVER                                                #
####################################################################################


# Resource Group Module is Used to Create Resource Groups
module "private-resolver-resourcegroup" {
  source = "./modules/azure-resourcegroup"
  # Resource Group Variables
  rg_name     = "rg-connectivity-adnspr-01"
  rg_location = "australiaeast"
}


module "spoke3-private-resolver-vnet" {
  source = "./modules/azure-vnet-resources"

  resource_group_name = module.private-resolver-resourcegroup.rg_name
  vnetwork_name       = "vnet-adnspr-vnet-01"
  location            = "australiaeast"
  vnet_address_space  = ["10.250.0.0/24"]

  # firewall_subnet_address_prefix = ["10.220.0.96/27"]
  # gateway_subnet_address_prefix  = ["10.220.0.0/26"]
  create_network_watcher = false

  # Adding Standard DDoS Plan, and custom DNS servers (Optional)
  create_ddos_plan = false

  # Multiple Subnets, Service delegation, Service Endpoints, Network security groups
  # These are default subnets with required configuration, check README.md for more details
  # NSG association to be added automatically for all subnets listed here.
  # First two address ranges from VNet Address space reserved for Gateway And Firewall Subnets.
  # ex.: For 10.1.0.0/16 address space, usable address range start from 10.1.2.0/24 for all subnets.
  # subnet name will be set as per Azure naming convention by defaut. expected value here is: <App or project name>
  subnets = {
    private-dns-inbound-subnet = {
      subnet_name           = "snet-adnspr-inbound-01"
      subnet_address_prefix = ["10.250.0.0/26"]


      delegation = {
        name = "Microsoft.Network.dnsResolvers"
        service_delegation = {
          actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
          name    = "Microsoft.Network/dnsResolvers"
        }
      }

      nsg_inbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
        # ["weballow", "100", "Inbound", "Allow", "Tcp", "80", "*", "0.0.0.0/0"],   
      ]

      nsg_outbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
        # ["ntp_out", "103", "Outbound", "Allow", "Udp", "123", "", "0.0.0.0/0"],
      ]
    }

    private-dns-outbound-subnet = {
      subnet_name           = "snet-adnspr-outbound-01"
      subnet_address_prefix = ["10.250.0.64/26"]
      # service_endpoints     = ["Microsoft.Storage"]

      nsg_inbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
        # ["weballow", "200", "Inbound", "Allow", "Tcp", "80", "*", ""],
      ]

      nsg_outbound_rules = [
        # [name, priority, direction, access, protocol, destination_port_range, source_address_prefix, destination_address_prefix]
        # To use defaults, use "" without adding any values.
      ]
    }

  }

  # Adding TAG's to your Azure resources (Required)
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}




module "dns-private-resolver" {
  source              = "./modules/azure-private-dns-resolver"
  resource_group_name = module.private-resolver-resourcegroup.rg_name
  location            = module.private-resolver-resourcegroup.rg_location
  dns_resolver_name   = "dnspr-connectivity-adnspr-01"
  virtual_network_id  = module.spoke3-private-resolver-vnet.virtual_network_id

  dns_resolver_inbound_endpoints = [
    # There is currently only support for two Inbound endpoints per Private Resolver.
    {
      inbound_endpoint_name = "inbound"
      inbound_subnet_id     = module.spoke3-private-resolver-vnet.subnet_ids_spokes[0]
    }
  ]

  dns_resolver_outbound_endpoints = [
    # There is currently only support for two Outbound endpoints per Private Resolver.
    {
      outbound_endpoint_name = "outbound"
      outbound_subnet_id     = module.spoke3-private-resolver-vnet.subnet_ids_spokes[1]
      forwarding_rulesets = [
        # There is currently only support for two DNS forwarding rulesets per outbound endpoint.
        {
          forwarding_ruleset_name = "default-ruleset"
        }
      ]
    }
  ]

  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}


#########################################Begin Implementing Private DNS Resolver####################################


# module "TPK_ddos_plan" {
#   source             = "./modules/ddos_plan"
#   ddos_plan_name     = "tpk-ddos-plan-australia"
#   rg_name            = module.hub-resourcegroup.rg_name
#   ddos_plan_location = module.hub-resourcegroup.rg_location
#   # ddos_plan_tags     = var.ddos_tags

#   depends_on = [module.hub-resourcegroup.rg_name]

#   providers = {
#     azurerm = azurerm.connectivity
#   }


# }
