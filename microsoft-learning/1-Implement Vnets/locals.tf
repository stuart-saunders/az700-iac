locals {

  subnets = merge([ for vnet_key, vnet_value in var.vnets :
    {
      for subnet_key, subnet_value in vnet_value.subnets :
        "${vnet_key}-${subnet_key}" => {
          vnet_key             = vnet_key
          location             = vnet_value.location
          subnet_key           = subnet_key
          subnet_address_space = subnet_value.address_space
          vms                  = subnet_value.vms
      }
    }
  ]...)

  vms = merge([ for subnet_key, subnet_value in local.subnets : 
    {
      for vm_value in subnet_value.vms :
        vm_value => {
          subnet_key  = subnet_value.subnet_key
          vnet_key    = subnet_value.vnet_key
          location    = subnet_value.location
      }
    }
  ]...)

  peerings = merge([ for vnet_key, vnet_value in var.vnets :
    {
      for peering_value in vnet_value.peerings :
        vnet_key => {
          target = peering_value
        }
    }
  ]...)
}