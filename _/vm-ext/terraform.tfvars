prefix = "az700-lab4"

vnets = {
  test-vnet = {    
    location = "UK South"
    address_space = "10.99.0.0/16"     
    subnets = {
      TestSubnet = {
        address_space = "10.99.0.0/24"
        vms = {
          testVM = {}
        }
      }
    }
  }
}