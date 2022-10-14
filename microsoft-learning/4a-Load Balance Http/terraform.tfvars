prefix = "az700-lab4"

vnets = {
  lab4-vnet = {
    location      = "UK South"
    address_space = "10.1.0.0/16"
    subnets = {
      BackendSubnet = {
        address_space = "10.1.0.0/24"
        vms = {
          bepool-vm1 = {
            availability_zone = 1
          }
          bepool-vm2 = {
            availability_zone = 2
          }
          bepool-vm3 = {
            availability_zone = 3
          }
          test-vm = {}
        }
      }
      FrontendSubnet = {
        address_space = "10.1.2.0/24"
      }
      AzureBastionSubnet = {
        address_space = "10.1.1.0/24"
      }
    }
  }
}