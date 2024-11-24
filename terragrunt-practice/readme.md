# **Terraform EKS Cluster Deployment**

This project provides Terraform modules to deploy an **Amazon Elastic Kubernetes Service (EKS)** cluster along with the associated VPC, EKS node group, and required configurations.

## **Directory Structure**

```plaintext
│   main.tf
│   kubernetes-deployment.tf
│   provider.tf
│   readme.md
│   terraform.tfvars
│   variables.tf
│
└───modules
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

---

## **Modules Overview**

### **1. VPC Module**
- **Path:** `modules/vpc`
- Creates a Virtual Private Cloud (VPC) with public and private subnets.
- Configurable CIDR blocks, availability zones, and tags.

### **2. EKS Cluster Module**
- **Path:** `modules/eks`
- Creates an EKS cluster with a specified Kubernetes version.
- Manages the cluster's IAM roles and subnet configurations.

### **3. EKS Node Group Module**
- **Path:** `modules/eks-node-group`
- Provisions a managed node group for the EKS cluster.
- Configurable instance types, scaling limits, and launch template settings.

---

## **How to Use**

### **1. Pre-Requisites**
- **Terraform CLI** installed (>= 1.0.0)
- **AWS CLI** configured with appropriate credentials and region.
- IAM permissions to manage EKS, VPC, and EC2 resources.

### **2. Configure Provider**
Set up the AWS provider in `provider.tf`:
```hcl
provider "aws" {
  region = "ap-northeast-2"
}
```

### **3. Input Variables**

Define the necessary variables in `terraform.tfvars`. Examples are provided in the file:

#### **VPC Configuration**
```hcl
vpc_config = {
  cidr_block = "173.10.0.0/16"
  availability_zones = [ "ap-northeast-2a", "ap-northeast-2c" ]
  subnets = [ 
    {
      subnet_name = "public-subnet-1"
      subnet_cidr = "173.10.0.0/20"
      subnet_type = "public"
    },
    {
      subnet_name = "private-subnet-1"
      subnet_cidr = "173.10.32.0/20"
      subnet_type = "private"
    }
  ]
  tags = {
    "Name" = "test-vpc"
    "env"  = "dev"
  }
}
```

#### **EKS Cluster Configuration**
```hcl
eks_iam_role_name = "eks-dev-cluster-iam-role"
eks_cluster_name = "eks-dev-cluster"
k8s_version = "1.30"
tags = {
  "Name" = "Dev_Infra"
  "Env"  = "dev"
}
```

#### **Node Group Configuration**
```hcl
node_group_name = "test-node-group"
node_group_role_name = "test-node-group-role"
node_instance_type = "t2.micro"
node_volume_size = 10
node_volume_type = "gp3"
required_nodes = 2
max_nodes = 3
min_nodes = 1
capacity_type = "ON_DEMAND"
ami_type = "AL2_x86_64"
```

# Kubernetes Deployment with Terraform

This Terraform configuration creates a basic Kubernetes deployment with an NGINX web server and exposes it through a LoadBalancer service.

## Components

### 1. Kubernetes Deployment
- Creates a deployment named `test-deployment`
- Runs 2 replicas of NGINX (version 1.21.6)
- Includes resource limits and requests for CPU and memory
- Exposes port 80

### 2. Kubernetes Service
- Creates a LoadBalancer service named `test-service`
- Routes traffic to the NGINX pods
- Exposes the application on port 80

## Resource Specifications

### Deployment Resources
- CPU Limits: 0.5 cores
- Memory Limits: 512Mi
- CPU Requests: 250m
- Memory Requests: 256Mi

### **4. Initialize Terraform**
Run the following command to initialize the working directory:
```bash
terraform init
```

### **5. Plan and Apply**
Generate an execution plan:
```bash
terraform plan
```
Apply the changes:
```bash
terraform apply
```

---

## **Modules Details**

### **VPC Module**
Handles VPC creation, including public and private subnets, and tags.
- **Inputs:** `vpc_config`
- **Outputs:**
  - `vpc_id`
  - `subnet_ids`
  - `subnet_ids_public`

---

### **EKS Cluster Module**
Creates an EKS cluster with the specified Kubernetes version and IAM roles.
- **Inputs:** `eks_cluster_name`, `eks_iam_role_name`, `k8s_version`, `tags`
- **Outputs:**
  - `eks_cluster_id`
  - `eks_cluster_endpoint`
  - `eks_cluster_security_group_id`

---

### **Node Group Module**
Provisions managed worker nodes for the EKS cluster.
- **Inputs:** Node configuration variables such as instance type, volume size, and scaling limits.
- **Outputs:**
  - `node_group_id`
  - `node_group_role_arn`

---

## **Outputs**

After applying, the following outputs will be available:
- VPC ID
- EKS Cluster ID
- EKS Cluster Endpoint
- Node Group Role ARN

---

## **Customizations**
- Update variables in `terraform.tfvars` to suit your environment.
- Extend modules by adding new outputs or resources if necessary.

---

## **Clean Up**
To destroy the infrastructure:
```bash
terraform destroy
```



