# Variables
variable "environment_tag" {
  type        = string
  description = "Environment tag value"
  default     = "cubem"
}
variable "region1" {
  type        = string
  description = "location 1 for the lab"
  default     = "australiaeast"
}
variable "region2" {
  type        = string
  description = "location 2 for the lab"
  default     = "australiasoutheast"
}
variable "virtual-wan-region1-hub1-prefix1" {
  type        = string
  description = "Address space for virtual-wan Location 1 Hub 1"
  default     = "10.10.10.0/23"
}
variable "virtual-wan-region2-hub1-prefix1" {
  type        = string
  description = "Address space for virtual-wan Location 2 Hub 1"
  default     = "10.10.12.0/23"
}
variable "region1-vnet1-address-space" {
  type        = string
  description = "VNET address space for region 1 vnet"
  default     = "10.10.11.0/24"
}
variable "region1-vnet1-snet1-range" {
  type        = string
  description = "Subnet address space for region 1 subnet"
  default     = "10.10.11.0/26"
}
variable "region1-vnet1-bastion-snet-range" {
  type        = string
  description = "Subnet address space for region 1 Bastion subnet"
  default     = "10.10.11.64/26"
}
variable "region2-vnet1-address-space" {
  type        = string
  description = "VNET address space for region 2 vnet"
  default     = "10.10.13.0/24"
}
variable "region2-vnet1-snet1-range" {
  type        = string
  description = "Subnet address space for region 2 subnet"
  default     = "10.10.13.0/26"
}
variable "region2-vnet1-bastion-snet-range" {
  type        = string
  description = "Subnet address space for region 2 Bastion subnet"
  default     = "10.10.13.64/26"
}
variable "vmsize" {
  type        = string
  description = "vm size"
  default     = "Standard_B2als_v2"
}
variable "adminusername" {
  type        = string
  description = "admin username"
  default     = "chamambom"
}
# Optional Resources
variable "azfw" {
  type        = bool
  description = "Sets if Azure Firewalls and Policy are created or not"
  default     = true
}
