resource_name_prefix = "mslearn-vnets"
location = "East US"

vnets = {
  CoreServicesVnet = {    
    location = "East US"
    address_space = "10.20.0.0/16"
    peerings = [ "ManufacturingVnet" ]
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
        vms = ["db-vm1", "db-vm2"]
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
    peerings = [ "CoreServicesVnet" ]
    subnets = {
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
    peerings = []
    subnets = {
      ResearchSystemSubnet = {
        address_space = "10.40.0.0/24"
        vms = []
      }
    }
  }
}