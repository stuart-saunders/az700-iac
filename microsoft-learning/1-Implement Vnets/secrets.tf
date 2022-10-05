# module "key_vault" {
#   source = "./modules/key-vault"  
#   key_vault_name = "${var.resource_name_prefix}-${formatdate("DDMMhhmm", timestamp())}-kv"  
#   resource_group_name = azurerm_resource_group.this.name
#   tenant_id           = data.azurerm_client_config.current.tenant_id

#   purge_protection_enabled    = false
#   enabled_for_disk_encryption = true
#   network_acls_default_action = "Allow"

#   policies = {
#     full = {
#       tenant_id               = data.azurerm_client_config.current.tenant_id
#       object_id               = data.azurerm_client_config.current.object_id
#       key_permissions         = []
#       secret_permissions      = var.kv_secret_permissions_full
#       certificate_permissions = []
#       storage_permissions     = []
#     }
#   }
# }

# resource "azurerm_key_vault_secret" "this" {
#   for_each = local.vms

#   name         = "${each.key}-password"
#   value        = module.database_vm[each.key].admin_password
#   key_vault_id = module.key_vault.id

#   depends_on = [module.key_vault.access_policy_ids]
# }


# OLD
# resource "azurerm_key_vault_secret" "database_vm_secret" {
#   for_each = var.database_vm

#   name         = "${each.value}-password"
#   value        = module.database_vm["${each.value}"].admin_password
#   key_vault_id = module.key_vault.id

#   depends_on = [module.key_vault.access_policy_ids]
# }

# resource "azurerm_key_vault_secret" "manufacturing_system_vm_secret" {
#   for_each = var.manufacturing_system_vm

#   name         = "${each.value}-password"
#   value        = module.manufacturing_system_vm["${each.value}"].admin_password
#   key_vault_id = module.key_vault.id

#   depends_on = [module.key_vault.access_policy_ids]
# }