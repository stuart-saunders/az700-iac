variable "prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "test_rg"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

variable "vnets" {
  type = map(object({
    location      = string
    address_space = string
    subnets       = map(object({
      address_space = string
      vms           = map(object({
        availability_zone = optional(number)
      }))
    }))
  }))
}

variable "iis_script_filename" {
  type        = string
  description = "The name of the local script file containing the VM extension script"
  default     = "iis_install.ps1"
}