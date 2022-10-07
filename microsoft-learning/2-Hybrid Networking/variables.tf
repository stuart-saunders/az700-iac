variable "resource_name_prefix" {
  type        = string
  description = "The prefix to add to resource names"
}

variable "location" {
  type        = string
  description = "The resource location"
}

variable "vnets" {
  type = map(object({
    location                    = string
    address_space               = string
    network_gateway             = bool
    network_gateway_connections = list(string)
    subnets                     = map(object({
      address_space = string
      vms           = list(string)
    }))
  }))
}

# Virtual Network Gateway
variable "network_gateway_type" {
  type        = string
  description = "The type of the Virtual Network Gateway. Valid options are Vpn or ExpressRoute"
  default     = "Vpn"
}

variable "network_gateway_subnet_name" {
  type        = string
  description = "The name for the required Network Gateway subnet"
  default     = "GatewaySubnet"
}

variable "network_gateway_vpn_type" {
  type        = string
  description = "The routing type of the Virtual Network Gateway. Valid options are RouteBased or PolicyBased"
  default     = "RouteBased"
}

variable "network_gateway_sku" {
  type        = string
  description = "Configuration of the size and capacity of the virtual network gateway"
  default     = "VpnGw1"
}

variable "network_gateway_generation" {
  type        = string
  description = " The Generation of the Virtual Network gateway"
  default     = "Generation1"
}

variable "network_gateway_connection_shared_key" {
  type        = string
  description = "The shared IPSec key"
}

# Virtual WAN
variable "virtual_wan_type" {
  type = string
  description = "Specifies the Virtual WAN type"
  default = "Standard"
}

variable "vhub" {
  type = object({
    location         = string
    address_prefix   = string
    vnet_connections = set(string)
  })
}

# Key Vault
variable "kv_secret_permissions_full" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
}