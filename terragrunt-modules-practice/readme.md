# Terragrunt Modules Practice
This repository contains Terragrunt configurations for managing AWS infrastructure using a modular approach.
## Project Structure
```
│   readme.md
│   terragrunt.hcl
│
├───dev
│   │   env.hcl
│   │
│   ├───eks
│   │       readme.md
│   │       terragrunt.hcl
│   │
│   ├───nodegroup
│   │       readme.md
│   │       terragrunt.hcl
│   │
│   └───vpc
│           readme.md
│           terragrunt.hcl
│
└───infrastructure-modules
    ├───eks
    │       main.tf
    │       outputs.tf
    │       variables.tf
    │
    ├───eks-node-group
    │       main.tf
    │       outputs.tf
    │       variables.tf
    │
    └───vpc
            main.tf
            outputs.tf
            variables.tf
```


## Configuration Details

### Root Terragrunt Configuration

The root `terragrunt.hcl` file contains:

1. **Remote State Configuration**
   - Uses local backend for state management
   - Automatically generates backend configuration
   - State files are stored relative to each module's path

2. **Provider Configuration**
   - Automatically generates AWS provider configuration
   - Region: ap-northeast-2 (Seoul)

## Getting Started

### Prerequisites

- Terraform (>= 0.12)
- Terragrunt (>= 0.28)
- AWS CLI configured with appropriate credentials

### Usage

1. Navigate to the desired environment directory:

```bash
cd terraform-basics-refined/terragrunt-modules-practice
```

2. Initialize Terragrunt:

```bash
terragrunt init
``` 

3. Plan your changes:

```bash
terragrunt plan
```

4. Apply the configuration:

```bash
terragrunt apply
```



## Running All Modules
### Run All Modules at Once
Terragrunt provides convenient commands to run operations across all modules:

1. **Plan All Modules**:

```bash
terragrunt run-all plan
```

2. **Apply All Modules**:

```bash
terragrunt run-all apply
```


3. **Destroy All Modules**:

```bash
terragrunt run-all destroy
```


4. **Output from All Modules**:

```bash
terragrunt run-all output
```

### Parallel Execution

To run commands in parallel (faster execution):

```bash
terragrunt run-all plan --parallel
terragrunt run-all apply --parallel
```


### Targeting Specific Modules

To run commands on specific modules that match a pattern:

```bash
terragrunt run-all plan --terragrunt-include-dir "/dev/eks"
```


### Dependencies

If your modules have dependencies, Terragrunt will automatically handle the correct execution order. You can also:

- Skip dependency checks:

```bash
terragrunt run-all apply --terragrunt-ignore-external-dependencies
```

- Include external dependencies:

```bash
terragrunt run-all apply --terragrunt-include-external-dependencies
```


### Common Flags

- `--terragrunt-non-interactive`: Run without any interactive prompts
- `--terragrunt-working-dir`: Specify which directory to run in
- `--terragrunt-source-update`: Update the source code for modules

Example of combining flags:

```bash
terragrunt run-all plan --terragrunt-non-interactive --terragrunt-working-dir dev/eks
```




## Generated Files

Terragrunt will automatically generate two files:

- `backend.tf`: Contains the backend configuration for state management
- `provider.tf`: Contains the AWS provider configuration

These files are automatically managed by Terragrunt and should not be edited directly.



## Notes

- The configuration uses the Seoul region (ap-northeast-2) for AWS resources
- All state files are stored locally, which is suitable for development but may need to be modified for production use.