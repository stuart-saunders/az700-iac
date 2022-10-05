# Microsoft Learn - Intro to Azure Virtual Networks

https://docs.microsoft.com/en-us/learn/modules/introduction-to-azure-virtual-networks

Additional files referenced in the Module available here:-
https://github.com/MicrosoftLearning/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/tree/master/Allfiles/Exercises

The exercises in this module require the creation of the Azure resources to support a fictional organisation's networking scenario. The organisation requires:-
- a VNet for its Core services, containing...
    - a Gateway Subnet
    - a Shared Services Subnet
    - a Database Subnet
    - a Public Web Service Subnet
- a VNet for its Manufacturing department, containing...
    - a Manufacturing System Subnet
    - Sensor1, Sensor2 and Sensor3 Subnets
- a VNet for its Research department, containing...
    - a Research System Subnet
- a Private DNS Zone to provide name resolution and allow VM resources in a VNet to communicate using their names
- the ability for the VMs in each VNet to be able to communicate with the VMs in other VNets
    - specifically, a peering is required between the Core Services VNet and the Manufacturing to allow the VMs in these VNets to communicate

The MS Learn module defines the steps within the portal to implement the above scenario. This folder uses Terraform to define the required infrastructure as code.

The code uses an internal module to define the Windows VM, which is then used to create the multiple VMs required in the scenario.

Azure Key Vault is used to store the passwords used for each VM. The VM module creates a random admin password and outputs the value. The output value is then added to Key Vault for secure storage.