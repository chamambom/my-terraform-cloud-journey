output "subnet_name_out" {
value = var.name
#value = values(azurerm_subnet.subnet)[*].name
#value = azurerm_subnet.subnet[*]
}

output "subnet_addresses_out" {
value = var.address_prefixes

}