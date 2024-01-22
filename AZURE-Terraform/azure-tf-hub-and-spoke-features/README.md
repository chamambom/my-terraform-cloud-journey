### I have created this repo to demonstrate how I have used terraform modules to deploy the following hub & spoke architecture resources.

#### Resource groups
    Deployed in various subscriptions to store different resources.
#### Public IPs
    For the VPN gateway, the Azure Firewall, The bastion Host.
#### hub vnet 
    Contains the Firewall, Bastion & Gateway Subnets
#### 2 spoke vnets
    Containes example workload subnets
#### spoke routes and vice versa
    route tables forcing all traffic to go through the firewall.
#### Firewall
     Azure firewall.
#### Bastion host
#### VPN Gateway
#### Firewall Rules
#### IP Groups
#### vnet peering - hub to spoke & vice versa


