##################################################
# VARIABLES                                      #
##################################################
variable "location" {
  type        = string
  description = "Region / Location where Azure DNS Resolver should be deployed"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group where resources are deployed"
}

# variable "virtual_network_name" {
#   type        = string
#   description = "Virtual Network Name"
# }

# variable "virtual_network_address_space" {
#   type        = list(string)
#   description = "List of all virtual network addresses"
# }

# variable "inbound_snet_name" {
#   type        = list(string)
#   description = "List of inbound subnet address prefixes"
# }

# variable "outbound_snet_name" {
#   type        = list(string)
#   description = "List of outbound subnet address prefixes"
# }

variable "dns_resolver_name" {
  type        = string
  description = "Name of the Azure DNS Private Resolver"
}

# variable "inbound_subnet_address_prefixes" {
#   type        = list(string)
#   description = "List of inbound subnet address prefixes"
# }

# variable "outbound_subnet_address_prefixes" {
#   type        = list(string)
#   description = "List of outbound subnet address prefixes"
# }

variable "virtual_network_id" {
  type        = string
  description = "(Required): ID of the associated virtual network"
}

variable "dns_resolver_inbound_endpoints" {
  description = "(Optional): Set of Azure Private DNS resolver Inbound Endpoints"
  type = set(object({
    inbound_endpoint_name = string
    inbound_subnet_id     = string
  }))
  # default = []
}

variable "dns_resolver_outbound_endpoints" {
  description = "(Optional): Set of Azure Private DNS resolver Outbound Endpoints with one or more Forwarding Rule sets"
  type = set(object({
    outbound_endpoint_name = string
    outbound_subnet_id     = string
    forwarding_rulesets = optional(set(object({
      forwarding_ruleset_name = optional(string)
    })))
  }))
  # default = []
}