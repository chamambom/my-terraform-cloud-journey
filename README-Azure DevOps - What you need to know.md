Azure DevOps - what you need to understand

### Initial requirements before you can begin deploying

There are some prior requirements you need to complete before we can get deploying Terraform using Azure DevOps. These are:-

    Where to store the Terraform state file?
    Azure DevOps Project
    Azure Service Principal
    Sample Terraform code

Lets have a look at each of these requirements; I will include an example of each and how you can configure.

### Where to store the Terraform state file?

When deploying Terraform there is a requirement that it must store a state file; this file is used by Terraform 
to map Azure Resources to your configuration that you want to deploy, keeps track of meta data and can also assist with 
improving performance for larger Azure Resource deployments.

Store your state file in a remote - Storage Account container 

You can boostrap this process with powershell or bash scripts but we will create these manually

### Login into your azure portal 
### Create a Resource Group - to house your storage account and all other resources that you will deploy
### Create a Storage Account
### Create a container inside the storage account

### Azure Service Principal

A Service Principal (SPN) is considered a best practice for DevOps within your CI/CD pipeline. It is used as an identity to authenticate you within your Azure Subscription to allow you to deploy the relevant Terraform code.

In this blog, I will show you how to create this manually (there is PowerShell / CLI but within this example I want you to understand the initial setup of this)

User should have ['Owner' or 'User Access Administrator'] role 
To begin creation, within your newly created Azure DevOps Project 
        select Project Settings then under pipelines
        Select Service Connections
        Scope Level (subscription or management group)  

Azure Pipeline Breakdown

Azure pipelines as code are created using .yaml syntax. the pipelines that you create will be versioned the same way as any code inside a Git Repository. 
 – making change to an Azure Pipeline? You can follow a pull-request process to ensure changes are verified and approved before being merged.
 -

Pipeline basics 

    Every pipeline that you create, must have one job
    A job is a step or can consist as a series of steps that run sequentially as an unit
    Moving from jobs to stages; each pipeline may even contain multiple stages, with each stage containing multiple jobs!

# Azure DevOps Extra Reading

1) Choose a process flow or process template to work in Azure Boards - https://learn.microsoft.com/en-us/azure/devops/boards/work-items/guidance/choose-process?view=azure-devops&tabs=agile-process
2) https://learn.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml
3) https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal
4) 

