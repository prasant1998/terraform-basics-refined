module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.15.0"

    name = var.vpc_name
    cidr = var.vpc_cidr
    azs = var.azs
    public_subnets = var.public_subnets_cidr
    private_subnets = var.private_subnets_cidr


    tags = {
        Terraform = "true"
        Enviornment = "dev"
    }
  
}


module "sg-module" {
    source = "./modules/security_group"
    sg_name = var.sg_name
    vpc_id = module.vpc.vpc_id
}



module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"

  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ module.sg-module.sg_id ]
  subnet_id = module.vpc.private_subnets[1]

  tags = {
    "Enviornment" = "dev"
  }
}





