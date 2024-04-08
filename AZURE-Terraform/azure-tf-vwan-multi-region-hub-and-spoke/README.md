# Azure Virtual WAN NonProd Environment

## Overview
This is a Terraform based demonstration of Azure Virtual WAN with 2 firewalls in two-regions AE and ASE.  

### What does this Lab Deploy?

This lab deploys the following Resources:

1. A Resource Group in two Azure Regions (AE & ASE) (based on variables)
2. A Virtual WAN in the Primary Region (AE)
3. A Virtual WAN Hub in two Azure Regions (AE & ASE)
4. A vNet in each Azure Region which is connected to the Virtual WAN Hub.
6. A Subnet and NSG in each of the above vNets.
7. A Subnet in each Region to be used for Azure Bastion.  
8. Azure Bastion in each Region to allow for access to the VMs for Testing. 
9. A Virtual Machine in each Azure Region (in the Regional vNets), to allow testing of Connectivity. 
10. A Custom Script Extension that runs on both VMs to add a few testing Apps (using Chocolatey) and allows ICMP through Windows Firewall for testing. 

### Enabling Azure Firewall

To enable Azure Firewall set the following variable to true within the terraform.tfvars file:

https://github.com/jakewalsh90/Terraform-Azure/blob/63d63c1e764c64e2143f01939f9ef04f866b4ae3/Virtual-WAN-Demo/terraform.tfvars#L17-L18