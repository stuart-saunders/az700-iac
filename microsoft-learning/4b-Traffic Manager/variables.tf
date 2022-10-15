variable "prefix" {
  type        = string
  description = "The prefix to add to resource names"
}

variable "resource_groups" {
  type = map(object({
    location = string
  }))
  description = "The Resource Groups to create and their locations"
}

variable "app_service_plans" {
  type = map(object({
    resource_group = string
    os_type        = string
    sku_name       = string
    web_apps = map(object({
      endpoint_name     = optional(string)
      endpoint_priority = optional(string)
    }))
  }))
}

variable "traffic_manager_profile_name" {
  type = string
  description = "The name of the Traffic Manager Profile"
}