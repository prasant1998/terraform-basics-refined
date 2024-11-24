module "vpc" {
    source = "./modules/vpc"
    env = var.env
    vpc_config = var.vpc_config
    private_subnet_tags = var.private_subnet_tags
    public_subnet_tags = var.public_subnet_tags
}


module "eks_cluster" {
    source = "./modules/eks"
    subnet_ids = module.vpc.subnet_ids
    eks_cluster_name = var.eks_cluster_name
    eks_iam_role_name = var.eks_iam_role_name
    k8s_version = var.k8s_version
    tags = var.tags
  
}


module "node_group" {
    source = "./modules/eks-node-group"
    cluster_name = module.eks_cluster.eks_cluster_name
    subnet_ids_public = module.vpc.subnet_ids_public
    node_group_name = var.node_group_name
    node_group_role_name = var.node_group_role_name
    launch_template_name_prefix = var.launch_template_name_prefix
    node_instance_type = var.node_instance_type
    node_volume_size = var.node_volume_size
    node_volume_type = var.node_volume_type
    required_nodes = var.required_nodes
    max_nodes = var.max_nodes
    min_nodes = var.min_nodes
    capacity_type = var.capacity_type
    ami_type = var.ami_type
}