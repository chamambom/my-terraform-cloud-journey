terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}


# Azure Virtual Network Gateway
resource azurerm_virtual_network_gateway "virtual_network_gateway" {
    name                = var.vpn_gateway_name
    location            = var.location
    resource_group_name = var.resource_group_name

    type     = var.type
    vpn_type = var.vpn_type
    sku           = var.sku
    active_active = var.active_active
    enable_bgp    = var.enable_bgp
    virtual_wan_traffic_enabled = var.virtual_wan_traffic_enabled
    remote_vnet_traffic_enabled = var.remote_vnet_traffic_enabled

    # I have converted this commented out block into a dynamic block to cater for 2 different types of vpn gateways with different parameters

    # ip_configuration {
    # name                          = "default"
    # private_ip_address_allocation = var.private_ip_address_allocation
    # subnet_id                     = var.subnet_id
    # public_ip_address_id          = var.public_ip_address_id
    # }

    # ip_configuration {
    # name                          = "ActiveActive"
    # private_ip_address_allocation = var.private_ip_address_allocation
    # subnet_id                     = var.subnet_id
    # public_ip_address_id          = var.public_ip_address_id_2
    # }

    dynamic "ip_configuration" {
    for_each = var.gateway_type == "active-active" ? toset(["default", "ActiveActive"]) : toset(["default"])

    content {
      name                          = ip_configuration.key
      private_ip_address_allocation = var.private_ip_address_allocation
      subnet_id                     = var.subnet_id

      # Conditionally assign public IP addresses
      public_ip_address_id = ip_configuration.key == "default" ? var.public_ip_address_id : var.public_ip_address_id_2
    }
 }

     # Conditionally include bgp_settings based on include_bgp_settings variable
  dynamic "bgp_settings" {
    for_each = var.include_bgp_settings ? [1] : []
    content {
      asn = var.gateway_asn

      peering_addresses {
        apipa_addresses       = ["169.254.21.7", "169.254.22.7"]
        ip_configuration_name = "default"
      }

      peering_addresses {
        apipa_addresses       =  ["169.254.21.5", "169.254.22.5"] 
        ip_configuration_name = "ActiveActive"
      }
    }
  }
}