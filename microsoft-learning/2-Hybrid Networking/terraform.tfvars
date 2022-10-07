resource_name_prefix = "az700-lab2"
location = "East US"

vnets = {
  CoreServicesVnet = {    
    location = "East US"
    address_space = "10.20.0.0/16"
    network_gateway = true
    network_gateway_connections = [ "ManufacturingVnet" ]    
    subnets = {
      GatewaySubnet = {
        address_space = "10.20.0.0/27"
        vms = []
      }
      SharedServicesSubnet = {
        address_space = "10.20.10.0/24"
        vms = []
      }
      DatabaseSubnet = {
        address_space = "10.20.20.0/24"
        vms = ["db-vm1"]
      }
      PublicWebServiceSubnet = {
        address_space = "10.20.30.0/24"
        vms = []
      }
    }
  }
  ManufacturingVnet = {
    location = "West Europe"
    address_space = "10.30.0.0/16"
    network_gateway = true
    network_gateway_connections = [ "CoreServicesVnet" ]
    subnets = {
      GatewaySubnet = {
        address_space = "10.30.0.0/27"
        vms = []
      }
      ManufacturingSystemSubnet = {
        address_space = "10.30.10.0/24"
        vms = ["mansys-vm1"]
      }
      SensorSubnet1 = {
        address_space = "10.30.20.0/24"
        vms = []
      }
      SensorSubnet2 = {
        address_space = "10.30.21.0/24"
        vms = []
      }
      SensorSubnet3 = {
        address_space = "10.30.22.0/24"
        vms = []
      }
    }
  }
  ResearchVnet = {
    location = "Southeast Asia"
    address_space = "10.40.0.0/16"
    network_gateway = false
    network_gateway_connections = [ ]
    virtual_hub_connecions = [ "" ]
    subnets = {
      ResearchSystemSubnet = {
        address_space = "10.40.0.0/24"
        vms = []
      }
    }
  }
}

network_gateway_connection_shared_key = "4-v3ry-53cr37-1p53c-5h4r3d-k3y"

vhub = {
  location = "West US"
  address_prefix = "10.60.0.0/24"
  vnet_connections = [ "ResearchVnet" ]
}