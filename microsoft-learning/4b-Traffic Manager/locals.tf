locals {

  web_apps = merge([for plan_key, plan_value in var.app_service_plans :
    {
      for webapp_key, webapp_value in plan_value.web_apps :
      webapp_key => {
        app_service_plan  = plan_key
        resource_group    = plan_value.resource_group
        endpoint_name     = webapp_value.endpoint_name
        endpoint_priority = webapp_value.endpoint_priority
      }
    }
  ]...)

}