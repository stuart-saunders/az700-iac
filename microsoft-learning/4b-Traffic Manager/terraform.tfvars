prefix = "az700-lab4-tf"

resource_groups = {
  tm1 = {
    location = "East US"
  }
  tm2 = {
    location = "West Europe"
  }
}

app_service_plans = {
  ContosoAppServicePlanEastUS = {
    resource_group = "tm1"
    os_type        = "Windows"
    sku_name       = "S1"
    web_apps = {
      Az700Lab4-ContosoWebApp-EastUS = {
        endpoint_name = "PrimaryEndpoint"
        endpoint_priority = 1
      }
    }
  }
  ContosoAppServicePlanWestEurope = {
    resource_group = "tm2"
    os_type        = "Windows"
    sku_name       = "S1"
    web_apps = {
      Az700Lab4-ContosoWebApp-WestEurope = {        
        endpoint_name = "FailoverEndpoint"
        endpoint_priority = 2
      }
    }
  }
}

traffic_manager_profile_name = "ContosoTMProfile-123456"
