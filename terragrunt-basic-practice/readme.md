# Terragrunt Practice Project
This repository contains Terragrunt configurations for managing AWS infrastructure using Infrastructure as Code (IaC) principles.
## Structure
The root configuration uses Terragrunt to:
 - Manage remote state storage locally (`terraform.tfstate` files)
 - Configure AWS provider for the ap-northeast-2 (Seoul) region
 - Provide a consistent configuration across all child directories
### Key Files
- `terragrunt.hcl` - Root configuration file that defines:
 - Local backend configuration for state management
 - AWS provider settings
 - Common configurations that can be inherited by child directories
## Configuration Details
### State Management
The project uses local backend storage for state files. Each child directory will maintain its own state file relative to its path.

```hcl
remote_state {
  backend = "local"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }
}
```


### Provider Configuration
AWS provider is configured for the Seoul region (ap-northeast-2).

## Getting Started

1. Ensure you have the following prerequisites installed:
   - Terraform
   - Terragrunt
   - AWS CLI (configured with appropriate credentials)

2. Initialize and run Terragrunt:
   ```bash
   terragrunt init
   terragrunt plan
   terragrunt apply
   ```
## Directory Structure

```
│   readme.md
│   terragrunt.hcl # Root terragrunt configuration
│
├───dev
│   └───vpc
│           readme.md # VPC configuration details
│           terragrunt.hcl # Terragrunt configuration for VPC
│
├───infrastructure-modules
│   ├───eks
│   │       main.tf # EKS module
│   │       outputs.tf # EKS outputs
│   │       variables.tf # EKS variables
│   │
│   ├───eks-node-group
│   │       main.tf # EKS node group module
│   │       outputs.tf # EKS node group outputs
│   │       variables.tf # EKS node group variables
│   │
│   └───vpc # VPC module
│           main.tf # VPC module
│           outputs.tf # VPC outputs
│           variables.tf # VPC variables
│
└───staging
    └───vpc
            readme.md # VPC configuration details
            terragrunt.hcl # Terragrunt configuration for VPC
```


## Best Practices

- Create child directories for different components/environments
- Use the DRY (Don't Repeat Yourself) principle by inheriting common configurations from this root configuration
- Review generated files (`backend.tf` and `provider.tf`) before applying changes

## Notes

- This configuration uses local state storage, which is suitable for learning and development. For production environments, consider using remote state storage (like S3) with state locking (DynamoDB).