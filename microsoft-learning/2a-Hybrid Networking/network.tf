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

resource "azurerm_public_ip" "this" {
  for_each = local.network_gateways

  name                         = "${each.key}Gateway-pip"
  location                     = each.value.location
  resource_group_name          = azurerm_resource_group.this.name
  allocation_method            = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "this" {
  for_each = local.network_gateways

  name                = "${each.key}Gateway"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.this.name

  type     = var.network_gateway_type
  vpn_type = var.network_gateway_vpn_type
  sku      = var.network_gateway_sku

  active_active = false
  enable_bgp    = false
  
  ip_configuration {
    name                          = "VnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.this[each.key].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.this["${each.key}-${var.network_gateway_subnet_name}"].id
  }
}

resource "azurerm_virtual_network_gateway_connection" "this" {
  for_each = local.network_gateway_connections

  name                = "${each.key}-to-${each.value.peer}"
  location            = azurerm_virtual_network.this[each.key].location
  resource_group_name = azurerm_resource_group.this.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.this[each.key].id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.this[each.value.peer].id

  shared_key = var.network_gateway_connection_shared_key
}