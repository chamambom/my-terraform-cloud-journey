
variable "vpn_gateway_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "type" {
}

variable "vpn_type" {
}

variable "sku" {
}

variable "active_active" {
}

variable "enable_bgp" {
}


variable "private_ip_address_allocation" {
}

variable "subnet_id" {
}

variable "public_ip_address_id" {  
}

variable "public_ip_address_id_2" {
  default = null
}

variable "gateway_asn" {
  type = string
  default = "65516"
}


variable "include_bgp_settings" {
  description = "Whether to include BGP settings"
  type        = bool
  default     = false
}

variable "virtual_wan_traffic_enabled" {
  type = string
    default     = null
}

variable "remote_vnet_traffic_enabled" {
  type = string
    default     = null
}

variable "gateway_type" {
  description = "Type of the gateway (active-standby or active-active)"
  type        = string
  default     = "active-standby"
}