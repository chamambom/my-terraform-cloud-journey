# # Azure Virtual Network peering between Virtual Network A and B
# resource "azurerm_virtual_network_peering" "peer_a2b" {
#   name                         = "peer-vnet-a-with-b"
#   resource_group_name          = var.rg-test-name
#   virtual_network_name         = var.virtual_network_name
#   remote_virtual_network_id    = azurerm_virtual_network.vnet_b.id
#   allow_virtual_network_access = true
# }
# # Azure Virtual Network peering between Virtual Network B and A
# resource "azurerm_virtual_network_peering" "peer_b2a" {
#   name                         = "peer-vnet-b-with-a"
#   resource_group_name          = var.rg-test-name
#   virtual_network_name         = var.virtual_network_name
#   remote_virtual_network_id    = azurerm_virtual_network.vnet_a.id
#   allow_virtual_network_access = true
#   depends_on                   = [azurerm_virtual_network_peering.peer_a2b]
# }


resource "azurerm_virtual_network_peering" "peering" {
  name                         = "${var.local_vnet_name}-to-${var.remote_vnet_name}"
  resource_group_name          = "${var.local_rg_name}"
  virtual_network_name         = "${var.local_vnet_name}"
  remote_virtual_network_id    = "${var.remote_vnet_id}"
  allow_virtual_network_access = "${var.allow_vnet_access}"
  allow_forwarded_traffic      = "${var.allow_forwarded_traffic}"
  allow_gateway_transit        = "${var.allow_gateway_transit}"
  use_remote_gateways          = "${var.use_remote_gateways}"  

}

