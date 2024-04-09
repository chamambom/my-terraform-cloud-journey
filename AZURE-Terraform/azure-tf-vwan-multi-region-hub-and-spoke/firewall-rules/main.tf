module "firewall-policy-global-rules" {
  source             = "./modules/azure-firewallrules"
  name               = "global-rules"
  firewall_policy_id = module.azure_firewall.azure_firewall_policy_id_out
  priority           = 100
  network_rule_collections = { //To the TPK Operations Team, this is where you add all your NETWORK rules.
    tpk-net-global-main = {
      priority = 105
      rules = {
        NPS_Radius_Servers_Outbound = { source_ip_groups = [module.ip_groups.ip_group_id_out[0]], destination_ip_groups = [module.ip_groups.ip_group_id_out[0]], protocols = ["UDP", "ICMP"], destination_ports = [1812, 1813, 1645, 1646] }
        NPS_Radius_Servers_Inbound  = { source_ip_groups = [module.ip_groups.ip_group_id_out[0]], destination_ip_groups = [module.ip_groups.ip_group_id_out[0]], protocols = ["UDP", "ICMP"], destination_ports = [1812, 1813, 1645, 1646] }
        AD_Servers_Inbound          = { source_ip_groups = [module.ip_groups.ip_group_id_out[0]], destination_ip_groups = [module.ip_groups.ip_group_id_out[0]], protocols = ["UDP", "TCP", "ICMP"], destination_ports = [389, 636, 445, 53, 3268, 3269, 88, 135, 464, 139, "49152-65535", 88] }
        AD_Servers_Outbound         = { source_ip_groups = [module.ip_groups.ip_group_id_out[0]], destination_ip_groups = [module.ip_groups.ip_group_id_out[0]], protocols = ["UDP", "TCP", "ICMP"], destination_ports = [389, 636, 445, 53, 3268, 3269, 88, 135, 464, 139, "49152-65535", 88] }
        AD_Servers_Outbound_Syslog  = { source_ip_groups = [module.ip_groups.ip_group_id_out[0]], destination_ip_groups = [module.ip_groups.ip_group_id_out[0]], protocols = ["UDP", "ICMP"], destination_ports = [514] }
        Test29Jan                   = { source_ip_groups = [module.ip_groups.ip_group_id_out[0]], destination_ip_groups = [module.ip_groups.ip_group_id_out[0]], protocols = ["Any"], destination_ports = ["*"] }
        Test2                       = { source_ip_groups = [module.ip_groups.ip_group_id_out[0]], destination_ip_groups = [module.ip_groups.ip_group_id_out[0]], protocols = ["Any"], destination_ports = ["*"] }
        test_AD_to_AOVPN            = { source_addresses = ["10.210.6.0/24"], destination_addresses = ["10.210.20.0/22"], protocols = ["Any"], destination_ports = ["*"] }
        Allow_AOVPN_to_DCs          = { source_addresses = ["10.210.20.0/22"], destination_addresses = ["10.210.6.4", "10.210.6.5", "10.200.48.104", "10.200.48.26"], protocols = ["TCP", "ICMP", "UDP"], destination_ports = [53, 445] }
      }
      tpk-net-global-blacklist = { //To the TPK Operations Team, this is where you add NETWORK rules in your blacklist - Any rules here are just placeholders, please change them accordingly.
        action   = "Deny"
        priority = 100
        rules = {
          NPS_Radius_Servers_Outbound = { source_ip_groups = [module.ip_groups.ip_group_id_out[0]], destination_ip_groups = [module.ip_groups.ip_group_id_out[0]], protocols = ["UDP", "ICMP"], destination_ports = [500] }
          NPS_Radius_Servers_Inbound  = { source_ip_groups = [module.ip_groups.ip_group_id_out[0]], destination_ip_groups = [module.ip_groups.ip_group_id_out[0]], protocols = ["UDP", "ICMP"], destination_ports = [500] }
        }
      }
    }
  }

  application_rule_collection = {
    tpk-app-global-main = { //To the TPK Operations Team, this is where you add all your APPLICATION rules.
      priority = 135
      rules = {
        Windows_Update            = { source_addresses = ["10.210.0.0/16"], destination_fqdn_tags = ["WindowsUpdate"], protocols = [{ type = "Http", port = "80" }, { type = "Https", port = "443" }] }
        SCEPman                   = { source_addresses = ["*"], destination_fqdns = ["app-scepmantpk-001.azurewebsites.net"], protocols = [{ type = "Http", port = "80" }, { type = "Https", port = "443" }] }
        Defender_Identity_Sensors = { source_addresses = ["10.210.6.4", "10.210.6.5"], destination_fqdns = ["*.atp.azure.com"], protocols = [{ type = "Http", port = "80" }, { type = "Https", port = "443" }] }
      }
    }
    tpk-app-global-blacklist = { //To the TPK Operations Team, this is where you add all your APPLICATION rules you want to block.
      action   = "Deny"
      priority = 130
      rules = {
        webcategories = { source_ip_groups = [module.ip_groups.ip_group_id_out[0]], web_categories = ["CriminalActivity"], protocols = [{}, { type = "Http", port = "80" }] }
      }
    }
  }
  nat_rule_collection = { //To the TPK Operations Team, this is where you add all your APPLICATION rules - The rules are just place holders, change them accordingly.
    tpk-nat-global-main = {
      priority = 100
      rules = {
        smtp-prd = { source_addresses = ["*"], destination_address = module.connectivity-public-ips.firewall_public_ip.ip_address, destination_port = 25, translated_address = "10.210.0.4", translated_port = 25 }
      }
    }
  }


  # providers = {
  #   azurerm = azurerm.connectivity
  # }
}
