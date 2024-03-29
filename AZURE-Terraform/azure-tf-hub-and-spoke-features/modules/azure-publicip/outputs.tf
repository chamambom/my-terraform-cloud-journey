output "bastion_public_ip_id" {
  value       = azurerm_public_ip.public_ip.0.id
  description = "The id of public-ip get from this"
}

output "vpn_gateway_public_ip_id" {
  value       = azurerm_public_ip.public_ip.1.id
  description = "The id of public-ip get from this"
}

output "firewall_public_ip_id" {
  value       = azurerm_public_ip.public_ip.2.id
  description = "The id of public-ip get from this"
}

output "firewall_public_ip" {
  value       = azurerm_public_ip.public_ip.2
  description = "The firewall public-ip"
}

