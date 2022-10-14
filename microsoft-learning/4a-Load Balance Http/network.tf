resource "azurerm_virtual_network" "this" {
  for_each = var.vnets

  name                = each.key
  location            = each.value.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [each.value.address_space]
}

resource "azurerm_subnet" "this" {
  for_each = local.subnets

  name                 = each.value.subnet_key
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this[each.value.vnet_key].name
  address_prefixes     = [each.value.subnet_address_space]
}

resource "azurerm_public_ip" "bastion-pip" {
  name                = "bastion-pip"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_bastion_host" "this" {
  name                = "bastion"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                 = "ip-configuration"
    subnet_id            = azurerm_subnet.this["${keys(var.vnets)[0]}-AzureBastionSubnet"].id
    public_ip_address_id = azurerm_public_ip.bastion-pip.id
  }
}