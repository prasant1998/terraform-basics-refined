module "vpc" {
    source = "./modules/vpc"
  
}


module "eks_cluster" {
    source = "./modules/eks"
    subnet_ids = module.vpc.subnet_ids
  
}


module "node_group" {
    source = "./modules/eks-node-group"
    cluster_name = module.eks_cluster.eks_cluster_name
    subnet_ids_public = module.vpc.subnet_ids_public
}