### I have created this repo to demonstrate how I have used terraform modules to deploy the following hub & spoke architecture resources.

#### Resource groups
    Deployed in various subscriptions to store different resources.
#### Public IPs
    For the VPN gateway, the Azure Firewall, The bastion Host.
#### hub vnet 
    Contains the Firewall, Bastion & Gateway Subnets
#### 2 spoke vnets
    Contains example workload subnets
#### spoke routes and vice versa
    route tables forcing all traffic to go through the firewall.
#### Firewall
     Azure firewall.
#### Azure private dns resolver
     Enables hybrid DNS connectivity between an organisation with on-premises and azure resources.
#### Azure private DNS
     Enable resolution of Azure resources.
#### Bastion host
     To connect securely to Azure resources
#### VPN Gateway
     Securely connect to Azure resources from on-premises
#### Firewall Rules
     Configure network and application firewall rules using IP Groups
#### IP Groups
     Group together IPs to make it easier to apply firewall rules.
#### vnet peering - hub to spoke & vice versa
    All spokes have to communicate through the hub.


