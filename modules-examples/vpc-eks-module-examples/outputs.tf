output "vpc_id" {
    value = module.vpc.vpc_id 
}

output "eks_cluster_name" {
    value = module.eks_cluster.eks_cluster_name
  
}

output "eks_cluster_endpoint" {
    value = module.eks_cluster.cluster_endpoint
  
}

