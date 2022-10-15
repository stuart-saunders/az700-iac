resource "azurerm_resource_group" "this" {
  for_each = var.resource_groups

  name     = "${var.prefix}-${each.key}-rg"
  location = each.value.location
}

resource "azurerm_service_plan" "this" {
  for_each = var.app_service_plans

  name                = each.key
  resource_group_name = azurerm_resource_group.this[each.value.resource_group].name
  location            = azurerm_resource_group.this[each.value.resource_group].location
  sku_name            = each.value.sku_name
  os_type             = each.value.os_type
}

resource "azurerm_windows_web_app" "this" {
  for_each = local.web_apps

  name                = each.key
  resource_group_name = azurerm_resource_group.this[each.value.resource_group].name
  location            = azurerm_service_plan.this[each.value.app_service_plan].location
  service_plan_id     = azurerm_service_plan.this[each.value.app_service_plan].id

  site_config {}
}