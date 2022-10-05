resource "azurerm_resource_group" "this" {
  name     = "${var.resource_name_prefix}-rg"
  location = var.location
}

module "vm" {
  for_each = local.vms

  source  = "./modules/win-vm"
  vm_name = "${each.key}"

  ip_configuration_name = "internal"
  subnet_id             = azurerm_subnet.this["${each.value.vnet_key}-${each.value.subnet_key}"].id  
  location              = each.value.location
  resource_group_name   = azurerm_resource_group.this.name
}