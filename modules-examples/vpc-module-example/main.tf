

module "vpc" {
  source            = "./vpc-module"  # Path to the VPC module
  cidr_block        = "10.0.0.0/16"
  vpc_name          = "my-vpc"
  public_subnet_1_cidr = "10.0.1.0/24"
  public_subnet_2_cidr = "10.0.2.0/24"
  private_subnet_1_cidr = "10.0.3.0/24"
  private_subnet_2_cidr = "10.0.4.0/24"
  availability_zone_1 = "ap-northeast-2a"
  availability_zone_2 = "ap-northeast-2c"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_1_id" {
  value = module.vpc.public_subnet_1_id
}

output "private_subnet_1_id" {
  value = module.vpc.private_subnet_1_id
}
