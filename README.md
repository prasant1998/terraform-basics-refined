# terraform-basics-refined
Enhanced Terraform basics with practical examples and best practices to streamline infrastructure provisioning.


This repository, terraform-basics-refined, is designed to deepen understanding of Terraform’s core concepts through practical examples and advanced usage techniques. It contains:

    Meta-Arguments Examples: Includes examples for count, depends_on, and for_each, illustrating efficient resource management with conditional logic and dependencies.

    Resource Blocks Examples: Demonstrates advanced control over resource states with examples for custom condition checks, lifecycle management, and provisioning strategies. 

    Variables & Outputs Examples: Understand how to work with Terraform variables and outputs to make our infrastructure configurations flexible, reusable, and manageable.

    Data Sources Examples: To retrieve data from external systems or cloud providers using Terraform data sources. These examples demonstrate how to query information about existing resources or configurations that are useful for dynamic infrastructure setups.


Directory & File Structure for the repo:


```


│   README.md
│
├───data-sources-example
│       main.tf
│       provider.tf
│       readme.md
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