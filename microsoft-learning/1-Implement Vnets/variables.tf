variable "resource_name_prefix" {
  type        = string
  description = "The prefix to add to resource names"
}

variable "vnets" {
  type = map(object({
    location      = string
    address_space = string
    peerings      = list(string)
    subnets       = map(object({
      address_space = string
      vms           = list(string)
    }))
  }))
}

variable "location" {
  type        = string
  description = "The resource location"
}

# Key Vault
variable "kv_secret_permissions_full" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
}