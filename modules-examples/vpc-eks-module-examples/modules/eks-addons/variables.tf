variable "enable_cluster_autoscaler" {
    description = "Enable Cluster Autoscaler"
    type = bool
    default = false
}

variable "env" {
    description = "Environment"
    type = string
}

variable "eks_cluster_name" {
    description = "EKS Cluster Name"
    type = string
}

variable "oidc_provider_arn" {
    description = "OIDC Provider ARN"
    type = string
}
