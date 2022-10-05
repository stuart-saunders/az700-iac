resource "azurerm_private_dns_zone" "this" {
  name                = "contoso.com"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.vnets

  name                  = "${each.key}Link"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = azurerm_virtual_network.this[each.key].id
  registration_enabled  = true
}