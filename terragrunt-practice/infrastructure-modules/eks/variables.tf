variable "eks_iam_role_name" {
    description = "EKS Cluster IAM Role Name"
    type = string
    default = "default-eks-cluster-iam-role"
  
}

variable "eks_cluster_name" {
    description = "Cluster Name"
    type = string
    default = "default-eks-cluster"
  
}

variable "k8s_version" {
    description = "Version for the Kubernetes"
    type = string
    default = "1.30"
  
}

variable "subnet_ids" {
    description = "List of Subnet Ids"
    type = list(string)
  
}


variable "tags" {
    description = "Tags for the Cluster"
    type = map(string)
    default = {
      "Name" = "test"
      "Env"  =  "dev"
      "Owner" =  "DevOps"
    }
  
}

variable "env" {
  description = "Enviornment for the Infrastructure"
  type = string
  
}