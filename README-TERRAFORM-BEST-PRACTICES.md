#Terraform Best Practices:

1- Keep it Simple (KISS) 
2- Use remote state
3- Use existing shared and community modules
4- Import existing infrastructure
5- Avoid variables hard-coding
6- Always format and validate
7- Use a consistent naming convention
8- Tag your Resources
9- Introduce Policy as Code
10- Implement a Secrets Management Strategy
11- Test your Terraform code
12- Enable debug/troubleshooting
13- Leverage Helper tools to make your life easier
14 - Auto generate doc with terraform-docs
15 - Keep your code DRY (Don't Repeat Yourself)
16 - Check security issues with tfsec, terrascan or checkov
17 - I will keep adding more as i explore.


Terraform is an Infrastructure as Code (IaC) tool that works across various cloud providers, including Azure, AWS, and others, enabling automation of infrastructure provisioning.
Getting Started

When beginning with Terraform, it's advantageous to consolidate all the Terraform code into a single .tf file, typically named main.tf. This approach is suitable for learning, testing, and smaller deployments.
File Organization

As your infrastructure deployment grows in size and complexity, it's recommended to organize Terraform code into multiple files. Here's a common file naming pattern:

    main.tf: This file defines locals, calls modules, and specifies data sources to create resources. It typically encompasses the primary components of the Terraform deployment.

    providers.tf: Add provider definitions for Terraform Providers utilized in your deployment, like azurerm. Providers can also be defined within main.tf, especially when only one or a few providers are in use.

    variables.tf: This file defines variables used by the Terraform deployment. These serve as input parameters passed into the Terraform code during deployment.

    outputs.tf: Define variables to output from the Terraform project or module.

    {customname}.tf: Custom Terraform files allowing flexibility to separate project code into any number of files according to your needs.

Example

css

project
│   main.tf
│   providers.tf
│   variables.tf
│   outputs.tf
│   custom_module.tf

Usage

To use Terraform effectively, adhere to these file organization guidelines, adjusting as necessary for your specific project requirements.

For more detailed information and examples, refer to the Terraform documentation.

