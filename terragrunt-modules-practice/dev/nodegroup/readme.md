# EKS Node Group Terragrunt Configuration

This Terragrunt configuration manages an Amazon EKS node group deployment for the development environment. It provisions and configures worker nodes that will join the EKS cluster.

## Overview

This configuration creates an EKS node group with the following components:
- Auto-scaling worker nodes
- Launch template configuration
- IAM roles and policies for the node group
- Node group networking configuration

## Dependencies

This module has the following dependencies:
- EKS Cluster (`../eks`)
- VPC Configuration (`../vpc`)

## Configuration Details

### Node Group Specifications
- Instance Type: `t2.micro`
- Disk Size: 10GB
- Disk Type: GP3
- Capacity Type: On-Demand
- AMI Type: Amazon Linux 2 (x86_64)

### Scaling Configuration
- Desired Capacity: 2 nodes
- Minimum Nodes: 1
- Maximum Nodes: 3

## Usage

To apply this configuration:

```bash
cd dev/nodegroup
terragrunt plan
terragrunt apply
```


### Prerequisites
- Terragrunt installed
- AWS credentials configured
- Parent EKS cluster must be deployed
- VPC and networking components must be deployed

## Structure

The configuration inherits common settings from:
- Root configuration (parent folder's `terragrunt.hcl`)
- Environment-specific variables (`env.hcl`)

## Module Source

This configuration uses the EKS node group module located at:
`../../infrastructure-modules/eks-node-group`



## Mock Outputs

For planning purposes, the configuration includes mock outputs for dependencies:
- EKS Cluster Name: "eks-dev-cluster"
- Public Subnet IDs: Mock subnet IDs are provided for testing

## Notes

- The node group uses public subnets for deployment
- The configuration is specifically tailored for the development environment
- All node group resources will be prefixed with "test-node-group"