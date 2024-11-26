terraform {
  source = "../../infrastructure-modules/eks"
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
  k8s_version = "1.30"
  enable_irsa = true
  subnet_ids = dependency.vpc.outputs.subnet_ids
  depends_on = [dependency.vpc]
  tags = {
    "Name"  = "Dev_Infra"
    "Env"   = "dev"
    "Owner" = "DevOps"
  }


}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    subnet_ids = ["subnet-1234567890abcdef0", "subnet-abcdef01234567890"]
  }
}


