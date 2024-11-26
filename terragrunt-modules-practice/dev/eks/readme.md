# EKS Cluster Terragrunt Configuration
This directory contains the Terragrunt configuration for deploying an Amazon Elastic Kubernetes Service (EKS) cluster in the development environment.
## Overview
This Terragrunt configuration manages the deployment of an EKS cluster with the following specifications:
 Environment: Development
 Kubernetes Version: 1.30
 IRSA (IAM Roles for Service Accounts) enabled
 VPC integration through dependency management
## Configuration Details
### Source Module
The configuration uses the EKS infrastructure module located at:

`../../infrastructure-modules/eks`

### Dependencies
- **VPC**: 
This configuration depends on the VPC module located in 

`../vpc`

    - Uses subnet IDs from the VPC module output
    - Includes mock outputs for planning without VPC module

### Key Features
- IRSA (IAM Roles for Service Accounts) enabled
- Integrated with environment-specific configurations via env.hcl
- Standardized tagging strategy
- Includes root configuration from parent folders
- Includes environment-specific variables from `env.hcl`

### Resource Tags

```hcl
tags = {
"Name" = "Dev_Infra"
"Env" = "dev"
"Owner" = "DevOps"
}
```

## Usage

To apply this configuration:

```bash
cd dev/eks
```

Initialize Terragrunt

```bash
terragrunt init
```

Plan the deployment

```bash
terragrunt plan
```

Apply the configuration

```bash
terragrunt apply
```


## Dependencies Management

This configuration includes mock outputs for the VPC dependency, allowing for isolated planning:

```hcl
mock_outputs = {
subnet_ids = ["subnet-1234567890abcdef0", "subnet-abcdef01234567890"]
}
```


## Notes
- Ensure the VPC module is deployed before applying this configuration
- Verify the Kubernetes version (1.30) is available in your region
- Review IRSA configuration if you plan to use Kubernetes service accounts with AWS IAM roles

## Related Documentation
- [Amazon EKS Documentation](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
- [Terragrunt Documentation](https://terragrunt.gruntwork.io/)
