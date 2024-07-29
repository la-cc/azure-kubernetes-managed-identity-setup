# AKS Bootstrap with Managed Identity and Workload Identity

This repository provides the necessary setup to bootstrap Azure Kubernetes Service (AKS) with Managed Identity and Workload Identity. The setup can be utilized for various blogs demonstrating different Kubernetes integrations with Azure Workload Identity.

## Setups Included

1. **Kubernetes: Manage External Secrets with Azure Workload Identity**
2. **Kubernetes: Cert Manager with Azure Workload Identity for DNS-01 Challenge**
3. **Kubernetes: External DNS with Azure Workload Identity**

## Overview

This repository aims to simplify the process of setting up a secure AKS environment with Azure Workload Identity. By leveraging Terraform, you can quickly provision AKS and configure it to manage secrets, certificates, and DNS with Azure Workload Identity.

## Prerequisites

Before you begin, ensure you have the following tools installed:

- [Azure CLI (`az`)](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Kubectl CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Helm CLI](https://helm.sh/docs/intro/install/)


## Setup Guide

### Step 1: Provision the Environment with Terraform

We will use a Terraform module to deploy a hardened AKS cluster. This cluster is suitable for production use, with local admin accounts disabled for better security. You will need Kubelogin to log in to the AKS cluster.

First, modify the values in the `terraform.tfvars` file according to your environment:

```hcl
# DNS
azure_cloud_zone = "midemo.example.com"

# Kubernetes
kubernetes_version        = "1.29.4"
orchestrator_version      = "1.29.4"
name                      = "midemo-development"
node_pool_count           = "3"
vm_size                   = "Standard_B4ms"
local_account_disabled    = true
load_balancer_sku         = "standard"
admin_list                = ["8a..."]
oidc_issuer_enabled       = true
workload_identity_enabled = true

# Key Vault
key_vault_name = "kv-midemo-c-dev-713"
key_vault_admin_object_ids = ["8a...."]

# Tags
tags = {
  TF-Managed  = "true"
  Environment = "development"
}
```

Initialize the Terraform provider:

```bash
terraform init
```

Build the plan:

```bash
terraform plan -var-file=terraform.tfvars
```
Apply the changes:

```bash
terraform apply -var-file=terraform.tfvars --auto-approve
```

### Step 2: Detailed Kubernetes Resource Deployment
For the detailed deployment of Kubernetes resources like External-Secrets-Operator, Cert Manager for DNS-01 Challenge, and External DNS, please refer to the respective blog posts linked below:

- [Setup 1: Kubernetes: Manage External Secrets with Azure Workload Identity](https://medium.com/@artem_lajko)
- [Setup 2: Kubernetes: Cert Manager with Azure Workload Identity for DNS-01 Challenge](https://medium.com/@artem_lajko)
- [Setup 3: Kubernetes: External DNS with Azure Workload Identity](https://medium.com/@artem_lajko)


## Conclusion

Congratulations! You've successfully set up AKS with Azure Workload Identity to manage secrets, certificates, and DNS configurations using a zero-trust approach. This setup ensures your Kubernetes workloads can securely interact with Azure resources without the need for static credentials, improving both security and simplicity.

For more details, refer to the specific blog posts linked above. Keep exploring and enhancing your Kubernetes deployments with Azure!