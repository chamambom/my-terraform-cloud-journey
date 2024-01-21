variable "subnets" {
  description = "Map of Azure VNET subnet configuration"
  type        = map(any)
  default = {
    app_subnet = {
      name                 = "app_subnet",
      resource_group_name  = "vCloud-lab.com",
      virtual_network_name = "example_vnet",
      address_prefixes     = ["10.1.1.0/24"]
    },
    db_subnet = {
      name                 = "db_subnet",
      resource_group_name  = "vCloud-lab.com",
      virtual_network_name = "example_vnet",
      address_prefixes     = ["10.1.2.0/24"]
    }
  }
}