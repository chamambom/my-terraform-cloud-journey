# terraform {
#   required_providers {
#     azurerm = {
#       source                = "hashicorp/azurerm"
#       version               = "~>3.0"
#       configuration_aliases = [azurerm]
#     }
#   }
# }

# Defining Local resources to be able to itegrate through multiple inbound and outbound endpoints, as well as multiple outbound forwarding rule sets.
locals {
  inbound_endpoint_map  = { for inboundendpoint in var.dns_resolver_inbound_endpoints : inboundendpoint.inbound_endpoint_name => inboundendpoint }
  outbound_endpoint_map = { for outboundendpoint in var.dns_resolver_outbound_endpoints : outboundendpoint.outbound_endpoint_name => outboundendpoint }

  outbound_endpoint_forwarding_rule_sets = flatten([
    for outbound_endpoint_key, outboundendpoint in var.dns_resolver_outbound_endpoints : [
      for forwarding_rule_set_key, forwardingruleset in outboundendpoint.forwarding_rulesets : {
        outbound_endpoint_name  = outboundendpoint.outbound_endpoint_name
        forwarding_ruleset_name = forwardingruleset.forwarding_ruleset_name
        outbound_endpoint_id    = azurerm_private_dns_resolver_outbound_endpoint.private_dns_resolver_outbound_endpoint[outbound_endpoint_key.outbound_endpoint_name].id
      }
    ]
  ])
}

# Creating the Azure Private DNS Resolver
resource "azurerm_private_dns_resolver" "private_dns_resolver" {
  name                = var.dns_resolver_name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.virtual_network_id
}

# Creating one or multiple Inbound Endpoints based on input map, note there is currently only support for two inbound endpoints per DNS Resolver, and they cannot share the same subnet.
resource "azurerm_private_dns_resolver_inbound_endpoint" "private_dns_resolver_inbound_endpoint" {
  for_each                = local.inbound_endpoint_map
  name                    = each.value.inbound_endpoint_name
  private_dns_resolver_id = azurerm_private_dns_resolver.private_dns_resolver.id
  location                = var.location

  ip_configurations {
    private_ip_allocation_method = "Dynamic" # Dynamic is default and only supported.
    subnet_id                    = each.value.inbound_subnet_id
  }
}

# Creating one or multiple Outbound Endpoints based on input map, note there is currently only support for two outbound endpoints per DNS Resolver, and they cannot share the same subnet.
resource "azurerm_private_dns_resolver_outbound_endpoint" "private_dns_resolver_outbound_endpoint" {
  for_each                = local.outbound_endpoint_map
  name                    = each.value.outbound_endpoint_name
  private_dns_resolver_id = azurerm_private_dns_resolver.private_dns_resolver.id
  location                = var.location
  subnet_id               = each.value.outbound_subnet_id
}

# Creating one or multiple DNS Resolver Forwarding rulesets, there is currently only support for two DNS forwarding rulesets per outbound endpoint
resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "forwarding_ruleset" {
  for_each = {
    for forwarding_rule_set in local.outbound_endpoint_forwarding_rule_sets : "${forwarding_rule_set.outbound_endpoint_name}-${forwarding_rule_set.forwarding_ruleset_name}" => forwarding_rule_set
  }
  name                                       = each.value.forwarding_ruleset_name
  resource_group_name                        = var.resource_group_name
  location                                   = var.location
  private_dns_resolver_outbound_endpoint_ids = [each.value.outbound_endpoint_id]
}

###########################################################
# Testing rule creation within the rule set created above #
###########################################################

resource "azurerm_private_dns_resolver_forwarding_rule" "corp_mycompany_com" {
  name = "corp" # Can only contain letters, numbers, underscores, and/or dashes, and should start with a letter.
  # dns_forwarding_ruleset_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/dnsForwardingRulesets/default-ruleset"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.forwarding_ruleset["outbound-default-ruleset"].id
  domain_name               = "afritek.co.nz." # Domain name supports 2-34 lables and must end with a dot (period) for example corp.mycompany.com. has three lables.
  enabled                   = true

  target_dns_servers {
    ip_address = "10.0.0.3"
    port       = 53
  }
  target_dns_servers {
    ip_address = "10.0.0.4"
    port       = 53
  }

}

# resource "azurerm_private_dns_resolver_virtual_network_link" "default" {
#   for_each                  = { for key, value in local.network_links : value.name => value }
#   name                      = "${each.key}-dnsfwrsvnetl"
#   dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.forwarding_ruleset["outbound-default-ruleset"].id
#   virtual_network_id        = each.value.vnet_id
# }

##################################################################################
# Testing: Adding Inbound Endpoint private ip as Custom DNS Server Configuration #
##################################################################################

# resource "azurerm_virtual_network" "vnet_custom_dns" {
#   name                = "vnet-custom-dns-server"
#   location            = azurerm_resource_group.dns_resolver.location
#   resource_group_name = azurerm_resource_group.dns_resolver.name
#   address_space       = ["10.0.0.0/16"]
#   dns_servers         = [module.dns-private-resolver.dns_resolver.dns_inbound_endpoints.inbound.inbound_endpoint_private_ip_address]
# }
