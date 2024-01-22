
output "tf_vnet1_id" {
  value = azurerm_virtual_network.tf-vnetwork-01.id
}
output "tf_vnet1_name" {
  value = azurerm_virtual_network.tf-vnetwork-01.name
}

output "subnet_with_LinuxVM_id" {
  value = azurerm_subnet.vnet1-subnet1.id
}



# output "vnetid_out" {
#   value = data.azurerm_virtual_network.example.id
# }

# output "vnetname_out" {
#   value = data.azurerm_virtual_network.example.name
# }

# output "vnetrg_out" {
#   value = data.azurerm_virtual_network.example.resource_group_name
# }