### VPC Variables


variable "vpc_config" {
  description = "Configuration for the AWS VPC and associated resources"
  type = object({
    cidr_block = string
    availability_zones = list(string)
    subnets = list(object({
      subnet_name = string
      subnet_cidr = string
      subnet_type = string 
    })) 
    tags = map(string)
  })
}


## k8s Variables


variable "eks_iam_role_name" {
    description = "EKS Cluster IAM Role Name"
    type = string
  
}

variable "eks_cluster_name" {
    description = "Cluster Name"
    type = string
  
}

variable "k8s_version" {
    description = "Version for the Kubernetes"
    type = string
  
}


variable "tags" {
    description = "Tags for the Cluster"
    type = map(string)
    default = {}
  
}

# Node Group Variables


variable "node_group_name" {
    description = "Name of the Node Group"
    type = string
}

variable "node_group_role_name" {
    description = "Name for the Node Group Role"
    type = string
  
}

variable "launch_template_name_prefix" {
    description = "Name Prefix for the launch template"
    type = string
    
  
}

variable "node_instance_type" {
    description = "Instance type of the Nodes"
    type = string
    
  
}

variable "node_volume_size" {
    description = "Size of the Node Volume"
    type = number
    
  
}

variable "node_volume_type" {
    description = "Volume type"
    type = string
    
  
}

variable "required_nodes" {
    description = "The No of Nodes Required"
    type = number
    
  
}

variable "max_nodes" {
    description = "The maximum no of nodes"
    type = number
    
  
}

variable "min_nodes" {
    description = "The Minimum no of Nodes "
    type = number
    
  
}

variable "capacity_type" {
    description = "Nodes Capacity Type "
    type = string
    
  
}

variable "ami_type" {
    description = "AMI Type for the Nodes "
    type = string
    
  
}


variable "env" {
  description = "Enviornment for the Infrastructure"
  type = string
  
}

variable "private_subnet_tags" {
  description = "Tags for the private subnets"
  type = map(string)
}

variable "public_subnet_tags" {
  description = "Tags for the public subnets"
  type = map(string)
}


# EKS Addons Variables

variable "enable_cluster_autoscaler" {
    description = "Enable Cluster Autoscaler"
    type = bool
}

variable "oidc_provider_arn" {
    description = "OIDC Provider ARN"
    type = string
}
