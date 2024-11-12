
module "vpc" {
  source            = "./vpc-module"  # Path to the VPC module
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_1_id" {
  value = module.vpc.public_subnet_1_id
}

output "public_subnet_2_id" {
  value = module.vpc.public_subnet_2_id
}

output "private_subnet_1_id" {
  value = module.vpc.private_subnet_1_id
}

output "private_subnet_2_id" {
  value = module.vpc.private_subnet_2_id
}