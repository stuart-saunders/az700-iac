resource "azurerm_traffic_manager_profile" "this" {
  name                   = var.traffic_manager_profile_name
  resource_group_name    = azurerm_resource_group.this["${keys(var.resource_groups)[0]}"].name
  traffic_routing_method = "Priority"

  dns_config {
    relative_name = var.traffic_manager_profile_name
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }
}

resource "azurerm_traffic_manager_azure_endpoint" "this" {
  for_each = local.web_apps

  name               = each.value.endpoint_name
  profile_id         = azurerm_traffic_manager_profile.this.id
  priority           = each.value.endpoint_priority
  target_resource_id = azurerm_windows_web_app.this[each.key].id
}