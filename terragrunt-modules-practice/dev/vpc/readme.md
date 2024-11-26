# VPC Terragrunt Configuration

This directory contains Terragrunt configuration for provisioning a Virtual Private Cloud (VPC) in AWS for the development environment.

## Overview

This configuration creates a VPC with the following specifications:
- CIDR Block: 173.10.0.0/16
- Region: ap-northeast-2 (Seoul)
- 2 Availability Zones: ap-northeast-2a, ap-northeast-2c
- 4 Subnets (2 public, 2 private)

## Subnet Configuration

### Public Subnets
1. public-subnet-1
   - CIDR: 173.10.0.0/20
   - AZ: ap-northeast-2a

2. public-subnet-2
   - CIDR: 173.10.16.0/20
   - AZ: ap-northeast-2c

### Private Subnets
1. private-subnet-1
   - CIDR: 173.10.32.0/20
   - AZ: ap-northeast-2a

2. private-subnet-2
   - CIDR: 173.10.64.0/20
   - AZ: ap-northeast-2c

## Structure

```
└── dev
    └── vpc
        └── terragrunt.hcl
```


## Dependencies

This configuration:
- Sources its base configuration from `../../infrastructure-modules/vpc`
- Includes root configuration from parent folders
- Includes environment-specific variables from `env.hcl`

## Tags

The configuration includes specific tags for EKS cluster integration:

### VPC Tags

```hcl
- Name: test-vpc
- kubernetes.io/cluster/eks-dev-cluster: shared
- kubernetes.io/role/internal-elb: 1
- env: dev
```

### Subnet Tags
Both private and public subnets are tagged appropriately for EKS integration with load balancers and cluster identification.

## Usage

To apply this configuration:

```bash
cd dev/vpc
terragrunt plan
terragrunt apply
```


## Notes

- This configuration is specifically designed for the development environment
- The VPC is configured to support an EKS cluster as indicated by the Kubernetes-specific tags
- The subnet layout follows AWS best practices for high availability with resources distributed across two availability zones

## Prerequisites

- Terragrunt installed
- AWS credentials configured
- Appropriate permissions to create VPC resources in AWS