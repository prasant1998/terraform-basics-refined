# VPC Configuration with Terragrunt

This directory contains the Terragrunt configuration for deploying a Virtual Private Cloud (VPC) in AWS for the development environment.

## Overview

This configuration creates a VPC with the following specifications:
- CIDR Block: 173.10.0.0/16
- Region: ap-northeast-2 (Seoul)
- Availability Zones: ap-northeast-2a, ap-northeast-2c

### Subnet Configuration

The VPC includes 4 subnets:

#### Public Subnets
1. Public-subnet-1
   - CIDR: 173.10.0.0/20
   - AZ: ap-northeast-2a

2. Public-subnet-2
   - CIDR: 173.10.16.0/20
   - AZ: ap-northeast-2c

#### Private Subnets
1. Private-subnet-1
   - CIDR: 173.10.32.0/20
   - AZ: ap-northeast-2a

2. Private-subnet-2
   - CIDR: 173.10.64.0/20
   - AZ: ap-northeast-2c

## Tags

### VPC Tags
```
Name: test-vpc
kubernetes.io/cluster/eks-dev-cluster: shared
kubernetes.io/role/internal-elb: 1
Env: dev
```


### Private Subnet Tags
```
Name: private-subnet
kubernetes.io/cluster/eks-dev-cluster: shared
kubernetes.io/role/internal-elb: 1
Env: dev
```

### Public Subnet Tags
```
Name: public-subnet
kubernetes.io/cluster/eks-dev-cluster: shared
kubernetes.io/role/internal-elb: 1
Env: dev
```



## Usage

To deploy this configuration:

1. Ensure you have Terragrunt installed
2. Configure your AWS credentials
3. Navigate to this directory
4. Run:
```
terragrunt init
terragrunt apply
```


## Dependencies

This configuration:
- Sources its base configuration from `../../infrastructure-modules/vpc`
- Includes parent Terragrunt configurations via `find_in_parent_folders()`

## Notes

- This VPC is configured specifically for EKS cluster deployment, as indicated by the Kubernetes-specific tags
- The subnet layout is designed to support high availability with resources spread across two availability zones
- All subnets are tagged appropriately for EKS use, including internal load balancer configurations.