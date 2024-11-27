terraform {
  source = "../../infrastructure-modules/eks-node-group"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path = find_in_parent_folders("env.hcl")
  expose = true
  merge_strategy = "no_merge"
}

inputs = {
    env = include.env.locals.env
    cluster_name = dependency.eks.outputs.eks_cluster_name 
    subnet_ids_public = dependency.vpc.outputs.subnet_ids_public
    depends_on = [dependency.eks, dependency.vpc]
    node_group_name             = "${include.env.locals.env}-node-group"
    node_group_role_name        = "${include.env.locals.env}-node-group-role"
    launch_template_name_prefix = "${include.env.locals.env}-node-group-launch-template"
    node_instance_type          = "t2.micro"
    node_volume_size            = 10
    node_volume_type            = "gp3"
    required_nodes              = 2
    max_nodes                   = 3
    min_nodes                   = 1
    capacity_type               = "ON_DEMAND"
    ami_type                    = "AL2_x86_64"
}

dependency "eks" {
  config_path = "../eks"
  mock_outputs = {
    eks_cluster_name = "eks-${include.env.locals.env}-cluster"
  }
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    subnet_ids_public = ["subnet-1234567890abcdef0", "subnet-abcdef01234567890"]
  }
}