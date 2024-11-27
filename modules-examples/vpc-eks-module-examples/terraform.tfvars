### VPC Variables Values

vpc_config = {
  cidr_block = "173.10.0.0/16"
    availability_zones = [ "ap-northeast-2a", "ap-northeast-2c" ]
    subnets = [ {
      subnet_name = "public-subnet-1"
      subnet_cidr = "173.10.0.0/20"
      subnet_type = "public"
    },
    {
      subnet_name = "public-subnet-2"
      subnet_cidr = "173.10.16.0/20"
      subnet_type = "public"
    },
    {
      subnet_name = "private-subnet-1"
      subnet_cidr = "173.10.32.0/20"
      subnet_type = "private"
    },
    {
      subnet_name = "private-subnet-2"
      subnet_cidr = "173.10.64.0/20"
      subnet_type = "private"
    } ]
    tags = {
      "Name" = "test-vpc"
      "kubernetes.io/cluster/eks-dev-cluster" = "shared"
      "kubernetes.io/role/internal-elb" = 1
      "env"  =  "dev"
    }
}


private_subnet_tags = {
  "Name" = "private-subnet"
  "kubernetes.io/cluster/eks-dev-cluster" = "shared"
  "kubernetes.io/role/internal-elb" = 1
  "Env"  =  "dev"
}

public_subnet_tags = {
  "Name" = "public-subnet"
  "kubernetes.io/cluster/eks-dev-cluster" = "shared"
  "kubernetes.io/role/internal-elb" = 1
  "Env"  =  "dev"
}

## EKS Variable Values

tags = {
  "Name" = "Dev_Infra"
  "Env"  =  "dev"
  "Owner" =  "DevOps"
}

eks_iam_role_name = "eks-dev-cluster-iam-role"
eks_cluster_name = "eks-dev-cluster"
k8s_version = "1.30"


# Node Group Variable Values


node_group_name = "test-node-group"
node_group_role_name = "test-node-group-role"
launch_template_name_prefix = "test-node-group-launch-template"
node_instance_type = "t2.micro"
node_volume_size = 10
node_volume_type = "gp3"
required_nodes = 2
max_nodes = 3
min_nodes = 1
capacity_type = "ON_DEMAND"
ami_type = "AL2_x86_64"
env = "dev"

# EKS Addons Variable Values

enable_cluster_autoscaler = true
oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/oidc.eks.ap-northeast-2.amazonaws.com/id/12345678901234567890"

