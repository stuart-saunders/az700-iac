resource "azurerm_virtual_network" "this" {
  for_each = var.vnets

  name                = each.key
  location            = each.value.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [ each.value.address_space ]
}

resource "azurerm_subnet" "this" {
  for_each = local.subnets

  name                 = each.value.subnet_key
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this[each.value.vnet_key].name
  address_prefixes     = [ each.value.subnet_address_space ]
}

resource "azurerm_virtual_network_peering" "this" {
  for_each = local.peerings

  name = "${each.key}-to-${each.value.target}"
  resource_group_name = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this[each.key].name
  remote_virtual_network_id = azurerm_virtual_network.this[each.value.target].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}