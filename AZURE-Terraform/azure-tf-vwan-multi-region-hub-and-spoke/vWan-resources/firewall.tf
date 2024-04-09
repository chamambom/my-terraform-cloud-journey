
###############################################################################
#                         Firewall in Region 1                                #
###############################################################################


# Azure Firewall Policy
resource "azurerm_firewall_policy" "fw-pol01" {
  count               = var.azfw ? 1 : 0
  name                = "nprod-fwpolicy-01-ae-parent"
  resource_group_name = azurerm_resource_group.region1-rg1.name
  location            = var.region1
}

# Create child policy
resource "azurerm_firewall_policy" "fw-pol01_child_policy" {
  name                = "child-policy-ae"
  resource_group_name = azurerm_resource_group.region1-rg1.name
  base_policy_id      = azurerm_firewall_policy.fw-pol01[0].id
  location            = var.region1

  # Define child policy settings
  # Add your policy settings here
}


# Azure Firewall
resource "azurerm_firewall" "region1-azfw" {
  count               = var.azfw ? 1 : 0
  name                = "AzureFirewall_nprod-vwan-01-ae-hub"
  location            = var.region1
  resource_group_name = azurerm_resource_group.region1-rg1.name
  sku_tier            = "Standard"
  sku_name            = "AZFW_Hub"
  firewall_policy_id  = azurerm_firewall_policy.fw-pol01_child_policy.id
  virtual_hub {
    virtual_hub_id  = azurerm_virtual_hub.region1-vhub1.id
    public_ip_count = 1
  }
}



# Azure Firewall Policy Rule Collection Group
resource "azurerm_firewall_policy_rule_collection_group" "network-rules1" {
  count              = var.azfw ? 1 : 0
  name               = "fw-pol01-rules"
  firewall_policy_id = azurerm_firewall_policy.fw-pol01_child_policy.id
  priority           = 100
  network_rule_collection {
    name     = "network_rules1"
    priority = 100
    action   = "Allow"
    rule {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP", "UDP", "ICMP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
}

###############################################################################
#                         Firewall in Region 2                                #
###############################################################################
# Azure Base Firewall Policy
resource "azurerm_firewall_policy" "fw-pol02" {
  count               = var.azfw ? 1 : 0
  name                = "nprod-fwpolicy-01-ase-parent"
  resource_group_name = azurerm_resource_group.region2-rg1.name
  location            = var.region2
}


# Create child policy
resource "azurerm_firewall_policy" "fw-pol02_child_policy" {
  name                = "child-policy-ase"
  resource_group_name = azurerm_resource_group.region2-rg1.name
  base_policy_id      = azurerm_firewall_policy.fw-pol02[0].id
  location            = var.region2

  # Define child policy settings
  # Add your policy settings here
}



resource "azurerm_firewall" "region2-azfw" {
  count               = var.azfw ? 1 : 0
  name                = "AzureFirewall_nprod-vwan-01-ase-hub"
  location            = var.region2
  resource_group_name = azurerm_resource_group.region2-rg1.name
  sku_tier            = "Standard"
  sku_name            = "AZFW_Hub"
  firewall_policy_id  = azurerm_firewall_policy.fw-pol02_child_policy.id
  virtual_hub {
    virtual_hub_id  = azurerm_virtual_hub.region2-vhub1.id
    public_ip_count = 1
  }
}






# Azure Firewall Policy Rule Collection Group
resource "azurerm_firewall_policy_rule_collection_group" "network-rules2" {
  count              = var.azfw ? 1 : 0
  name               = "fw-pol02-rules"
  firewall_policy_id = azurerm_firewall_policy.fw-pol02_child_policy.id
  priority           = 100
  network_rule_collection {
    name     = "network_rules2"
    priority = 100
    action   = "Allow"
    rule {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP", "UDP", "ICMP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
}

