Terraform is an IaC cloud agnostic tool used to automate provisioning of infrastructure on Azure , AWS and all the other cloud providers.

When getting started with Terraform, it’s great to start by writing all the Terraform code in a single Terraform (.tf) file. A general standard is to name this file main.tf. This is something that works great for learning, testing, and for smaller infrastructure deployments.

When an infrastructure deployment starts growing in size, and becoming more complex, it’s a good best practice to break out the Terraform code into multiple files. The following file names are a common pattern used across the community that uses Terraform:

    main.tf – Define locals (aka variables used within the deployment), call modules, and data sources to create all resources. Generally, this contains these primary components of the Terraform deployment.
    providers.tf – Add the provider definitions for the Terraform Providers your deployment is using (such as azurerm). Often times, this file may be combined within the main.tf file instead of having a separate file since often only one or a couple providers will be in use.
    variables.tf – Define the variables used by the Terraform deployment. These are the “input parameters” that will be passed into the Terraform code at deployment time.
    outputs.tf – Define variables to output from the Terraform project or module.
    {customname}.tf – Your own custom Terraform files. You can optionally separate your Terraform project code into any number of Terraform files.


