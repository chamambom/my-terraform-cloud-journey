# terraform {
#   required_providers {
#     azurerm = {
#       source                = "hashicorp/azurerm"
#       version               = "~>3.0"
#       configuration_aliases = [azurerm]
#     }
#   }
# }




# Firewall Policy Rules
resource "azurerm_firewall_policy_rule_collection_group" "az-collection-pol01" {
  name = var.azure_firewall_policy_coll_group_name

  #Associating Azure Firewall with Firewall Manager Policy
  firewall_policy_id = var.azure_firewall_policy_id
  priority           = var.priority

  network_rule_collection {
    name     = var.network_rule_coll_name_01
    priority = var.network_rule_coll_priority_01
    action   = var.network_rule_coll_action_01
    dynamic "rule" {
      for_each = var.network_rules_01
      content {
        name = rule.value.name
        # source_addresses      = rule.value.source_addresses
        # destination_addresses = rule.value.destination_addresses
        source_ip_groups      = rule.value.source_ip_groups
        destination_ip_groups = rule.value.destination_ip_groups
        destination_ports     = rule.value.destination_ports
        protocols             = rule.value.protocols
      }
    }
  }

  network_rule_collection {
    name     = var.network_rule_coll_name_02
    priority = var.network_rule_coll_priority_02
    action   = var.network_rule_coll_action_02
    dynamic "rule" {
      for_each = var.network_rules_02
      content {
        name = rule.value.name
        # source_addresses      = rule.value.source_addresses
        # destination_addresses = rule.value.destination_addresses
        source_ip_groups      = rule.value.source_ip_groups
        destination_ip_groups = rule.value.destination_ip_groups
        destination_ports     = rule.value.destination_ports
        protocols             = rule.value.protocols
      }
    }
  }

  application_rule_collection {
    name     = var.application_rule_coll_name
    priority = var.application_rule_coll_priority
    action   = var.application_rule_coll_action
    dynamic "rule" {
      for_each = var.application_rules
      content {
        name              = rule.value.name
        source_addresses  = rule.value.source_addresses
        destination_fqdns = rule.value.destination_fqdns
        dynamic "protocols" {
          for_each = var.application_protocols
          content {
            type = protocols.value.type
            port = protocols.value.port
          }
        }
      }
    }
  }
}
