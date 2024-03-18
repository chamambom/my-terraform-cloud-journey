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
  default     = "10.10.10.0/24"
}
variable "virtual-wan-region2-hub1-prefix1" {
  type        = string
  description = "Address space for virtual-wan Location 2 Hub 1"
  default     = "10.10.12.0/24"
}
variable "region1-vnet1-address-space" {
  type        = string
  description = "VNET address space for region 1 vnet"
  default     = "192.168.1.0/24"
}
variable "region1-vnet1-snet1-range" {
  type        = string
  description = "Subnet address space for region 1 subnet"
  default     = "192.168.1.0/25"
}
variable "region1-vnet1-bastion-snet-range" {
  type        = string
  description = "Subnet address space for region 1 Bastion subnet"
  default     = "192.168.1.128/26"
}
variable "region2-vnet1-address-space" {
  type        = string
  description = "VNET address space for region 2 vnet"
  default     = "192.168.2.0/24"
}
variable "region2-vnet1-snet1-range" {
  type        = string
  description = "Subnet address space for region 2 subnet"
  default     = "192.168.2.0/25"
}
variable "region2-vnet1-bastion-snet-range" {
  type        = string
  description = "Subnet address space for region 2 Bastion subnet"
  default     = "192.168.2.128/26"
}
variable "vmsize" {
  type        = string
  description = "vm size"
  default     = "Standard_B2s"
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
