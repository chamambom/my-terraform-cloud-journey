# Creates Log Anaylytics Workspace
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace

resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-nprod-01"
  location            = var.region1
  resource_group_name = azurerm_resource_group.region1-rg1.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
