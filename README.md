# Terraform-basics-refined
Enhanced Terraform basics with practical examples and best practices to streamline infrastructure provisioning.


This repository, terraform-basics-refined, is designed to deepen understanding of Terraform’s core concepts through practical examples and advanced usage techniques. It contains:

    Meta-Arguments Examples: Includes examples for count, depends_on, and for_each, illustrating efficient resource management with conditional logic and dependencies.

    Resource Blocks Examples: Demonstrates advanced control over resource states with examples for custom condition checks, lifecycle management, and provisioning strategies. 

    Variables & Outputs Examples: Understand how to work with Terraform variables and outputs to make our infrastructure configurations flexible, reusable, and manageable.

    Data Sources Examples: To retrieve data from external systems or cloud providers using Terraform data sources. These examples demonstrate how to query information about existing resources or configurations that are useful for dynamic infrastructure setups.

    Modules Examples: Dive into Terraform Modules, which allow us to group resources and reuse configurations across different parts of our infrastructure. These examples showcase how to structure and call modules, making our infrastructure modular, scalable, and easy to maintain.

    Additionally, I have added function examples to which I have done try function and lookup function.

    I have also updated examples for dynamic blocks, which include examples related to security groups.


# Directory & File Structure for the repo:


```

│   README.md
│
├───conditional-examples
│       main.tf
│       provider.tf
│       readme.md
│
├───data-sources-example
│       main.tf
│       provider.tf
│       readme.md
│
├───dynamic-block-examples
│       main.tf
│       provider.tf
│       readme.md
│
├───for-examples
│       main.tf
│       provider.tf
│       readme.md
│
├───functions-examples
│   ├───flatten-examples
│   │       main.tf
│   │       provider.tf
│   │       readme.md
│   │
│   ├───lookup-function-example
│   │       main.tf
│   │       provider.tf
│   │       readme.md
│   │
│   ├───toset-examples
│   │       main.tf
│   │       provider.tf
│   │       readme.md
│   │
│   └───try-function-examples
│       │   main.tf
│       │   provider.tf
│       │   readme.md
│       │
│       └───vpc-module
│               main.tf
│               outputs.tf
│               variables.tf
│
├───integrating-modules-examples
│   ├───vpc-module-ec2-module-securtiy-group-module
│   │   │   main.tf
│   │   │   outputs.tf
│   │   │   provider.tf
│   │   │   readme.md
│   │   │   terraform.tfvars
│   │   │   variables.tf
│   │   │
│   │   └───modules
│   │       └───security_group
│   │               main.tf
│   │               outputs.tf
│   │               variables.tf
│   │
│   └───vpc-module-integrating-ec2-module
│       │   main.tf
│       │   outputs.tf
│       │   provider.tf
│       │   readme.md
│       │
│       └───modules
│           └───ec2-instance
│                   main.tf
│                   outputs.tf
│                   variables.tf
│
├───local-value-example
│       main.tf
│       provider.tf
│       readme.md
│
├───meta-arguments-examples
│   ├───count-example
│   │       main.tf
│   │       provider.tf
│   │       readme.md
│   │
│   ├───depends-on_example
│   │       main.tf
│   │       provider.tf
│   │       readme.md
│   │
│   ├───for_each
│   │       main.tf
│   │       provider.tf
│   │       readme.md
│   │
│   └───lifecycle-example
│           image.png
│           main.tf
│           provider.tf
│           readme.md
│
├───modules-examples
│   ├───ec2-instance-module-example
│   │   │   main.tf
│   │   │   provider.tf
│   │   │   readme.md
│   │   │
│   │   └───ec2-instance
│   │           main.tf
│   │           outputs.tf
│   │           variables.tf
│   │
│   ├───vpc-eks-module-examples
│   │   │   kubernetes-deployment.tf
│   │   │   main.tf
│   │   │   outputs.tf
│   │   │   provider.tf
│   │   │   readme.md
│   │   │   terraform.tfvars
│   │   │   variables.tf
│   │   │
│   │   └───modules
│   │       ├───eks
│   │       │       main.tf
│   │       │       outputs.tf
│   │       │       variables.tf
│   │       │
│   │       ├───eks-node-group
│   │       │       main.tf
│   │       │       outputs.tf
│   │       │       variables.tf
│   │       │
│   │       └───vpc
│   │               main.tf
│   │               outputs.tf
│   │               variables.tf
│   │
│   ├───vpc-module-example
│   │   │   main.tf
│   │   │   provider.tf
│   │   │   readme.md
│   │   │
│   │   └───vpc-module
│   │           main.tf
│   │           outputs.tf
│   │           variables.tf
│   │
│   └───vpc-module-example-revised
│       │   main.tf
│       │   provider.tf
│       │   readme.md
│       │   terraform.tfvars
│       │   variables.tf
│       │
│       └───vpc-module
│               main.tf
│               outputs.tf
│               variables.tf
│
├───resource-blocks-examples
│   ├───custom-condition-check-example
│   │       image.png
│   │       main.tf
│   │       provider.tf
│   │       readme.md
│   │
│   ├───lifecycle-provisoner-example
│   │       image.png
│   │       main.tf
│   │       provider.tf
│   │       readme.md
│   │
│   └───lifecycle-resources-state-example
│           00-provider.tf
│           01-remove-resource-from-state-file.tf
│           image.png
│           readme.md
│
└───variables&outputs-examples
    ├───input-variables-examples
    │       main.tf
    │       provider.tf
    │       readme.md
    │
    └───output-value-example
        │   main.tf
        │   provider.tf
        │   readme.md
        │
        └───module-output-example
            │   main.tf
            │   provider.tf
            │   readme.md
            │
            └───compute
                    ec2_instance.tf


```