terraform {
  source = "../../infrastructure-modules/vpc"
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
  vpc_config = {
  cidr_block         = "173.10.0.0/16"
  availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]
  subnets = [{
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
  }]
  tags = {
    "Name"                                  = "test-vpc"
    "kubernetes.io/cluster/eks-dev-cluster" = "shared"
    "kubernetes.io/role/internal-elb"       = 1
    "env"                                   = "dev"
    }
  }
  private_subnet_tags = {
    "Name"                                  = "private-subnet"
    "kubernetes.io/cluster/eks-dev-cluster" = "shared"
    "kubernetes.io/role/internal-elb"       = 1
    "Env"                                   = "dev"
  }
  public_subnet_tags = {
    "Name"                                  = "public-subnet"
    "kubernetes.io/cluster/eks-dev-cluster" = "shared"
    "kubernetes.io/role/internal-elb"       = 1
    "Env"                                   = "dev"
  }
}

