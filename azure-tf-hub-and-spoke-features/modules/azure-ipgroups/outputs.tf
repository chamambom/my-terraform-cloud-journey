output "ip_group_1_id_out" {
  value = values(azurerm_ip_group.tpk_ipgroups)[0].id
# module.ip_groups.azurerm_ip_group.tpk_ipgroups["AD_Servers_IP_Group"] will be created
}

output "ip_group_2_id_out" {
  value = values(azurerm_ip_group.tpk_ipgroups)[1].id
 # module.ip_groups.azurerm_ip_group.tpk_ipgroups["NPS_Radius_Servers_IP_Group"] will be created
}

