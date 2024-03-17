output "virtual_network_gateway_id_out" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network_gateway.virtual_network_gateway.id
}
