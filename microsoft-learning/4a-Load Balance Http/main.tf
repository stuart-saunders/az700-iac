resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg"
  location = var.location
}

module "vm" {
  for_each = local.vms

  source  = "./modules/win-vm"
  vm_name = each.key

  ip_configuration_name = "internal"
  subnet_id             = azurerm_subnet.this["${each.value.vnet_key}-${each.value.subnet_key}"].id
  location              = each.value.location
  resource_group_name   = azurerm_resource_group.this.name
}

data "template_file" "iis" {
  template = file("scripts/install_iis.ps1")
}

resource "azurerm_virtual_machine_extension" "iis" {
  for_each = module.vm

  name                 = each.value.name
  virtual_machine_id   = module.vm[each.value.name].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<-SETTINGS
    {     
      "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.iis.rendered)}')) | Out-File -filepath install_iis.ps1\" && powershell -ExecutionPolicy Unrestricted -File install_iis.ps1"
    }
  SETTINGS
}