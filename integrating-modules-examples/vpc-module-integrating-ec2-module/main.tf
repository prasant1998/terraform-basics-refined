module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.15.0"

    name = "my-test-vpc"
    cidr = "192.168.0.0/16"
    azs = ["ap-northeast-2a", "ap-northeast-2c"]
    public_subnets = ["192.168.101.0/24", "192.168.102.0/24"]
    private_subnets = ["192.168.201.0/24", "192.168.202.0/24"]


    tags = {
        Terraform = "true"
        Enviornment = "dev"
    }
  
}


data "aws_ami" "latest_amazon" {
    most_recent = true
    owners = ["amazon"]

    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}


module "ec2_instance" {
    source = "./modules/ec2-instance"
    instance_name = "MyEc2Instance"
    instance_type = "t2.micro"
    ami_id = data.aws_ami.latest_amazon.id
    subnet_id = module.vpc.public_subnets[0]
  
}



