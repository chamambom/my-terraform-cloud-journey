output "StgActName" {
  value = module.storage_account.stg_act_name_out
}

output "RgName" {
  value = module.resource_group.rg_name_out
}

 output "mysubnet" {
  value = module.subnet
  }


  output "myvnets" {
  value = module.virtual_network
  }