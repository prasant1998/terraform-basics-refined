# A VPC Module

```
vpc-module-example/
├── main.tf            # Root module (calls the VPC module)
├── vpc-module/        # Module directory
│   ├── main.tf        # VPC module definition
│   ├── variables.tf   # VPC module variables
│   └── outputs.tf     # VPC module outputs

```

VPC Module Definition (vpc-module/main.tf)

Input Variables for VPC Module (vpc-module/variables.tf)

Outputs for VPC Module (vpc-module/outputs.tf)

Using the VPC Module in the Root Configuration (main.tf)

This root module uses the vpc module to create a VPC with two subnets, and outputs the VPC and subnet IDs.