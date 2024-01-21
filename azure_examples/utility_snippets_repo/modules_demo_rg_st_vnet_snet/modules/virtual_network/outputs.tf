#Azure virtual network module output.tf file
output "vnet_name" {
    value = var.name    
}

output "resource_group_out" {
    value = var.resource_group_name    
}


output "vnet_space_out" {
    value =  var.address_space 
}


