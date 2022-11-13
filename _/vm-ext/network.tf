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