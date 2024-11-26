# VPC Configuration with Terragrunt

This directory contains the Terragrunt configuration for managing a VPC (Virtual Private Cloud) in AWS for the staging environment.

## Overview

This configuration creates a VPC with the following specifications:
- CIDR Block: 173.10.0.0/16
- Region: ap-northeast-2 (Seoul)
- 2 Availability Zones: ap-northeast-2a, ap-northeast-2c
- 4 Subnets (2 public, 2 private)

## Subnet Layout

| Subnet Name | CIDR Block | Type | Availability Zone |
|------------|------------|------|-------------------|
| public-subnet-1 | 173.10.0.0/20 | Public | ap-northeast-2a |
| public-subnet-2 | 173.10.16.0/20 | Public | ap-northeast-2c |
| private-subnet-1 | 173.10.32.0/20 | Private | ap-northeast-2a |
| private-subnet-2 | 173.10.64.0/20 | Private | ap-northeast-2c |

## Prerequisites

- Terragrunt installed
- AWS credentials configured
- Access to the referenced infrastructure-modules/vpc source

## Usage

To apply this configuration:

```
terragrunt init
terragrunt apply
```


## Configuration Details

### Source Module
The configuration uses a VPC module located at `../../infrastructure-modules/vpc`

### Tags

The configuration includes specific tags for EKS (Elastic Kubernetes Service) integration:

#### VPC Tags
- Name: test-vpc
- kubernetes.io/cluster/eks-staging-cluster: shared
- kubernetes.io/role/internal-elb: 1
- env: staging

#### Private Subnet Tags
- Name: private-subnet
- kubernetes.io/cluster/eks-staging-cluster: shared
- kubernetes.io/role/internal-elb: 1
- Env: staging

#### Public Subnet Tags
- Name: public-subnet
- kubernetes.io/cluster/eks-staging-cluster: shared
- kubernetes.io/role/internal-elb: 1
- Env: staging

## Notes

- This configuration is specifically for the staging environment
- The VPC is configured to support EKS cluster deployment
- The subnet layout follows AWS best practices for high availability

## Related Files

- `terragrunt.hcl`: Main configuration file
- Parent configuration is included via `find_in_parent_folders()`

## Contributing

When making changes to this configuration:
1. Always test changes with `terragrunt plan` first
2. Ensure EKS-related tags are preserved
3. Maintain the existing CIDR structure unless there's a specific need to change it
