# Using Locals to Simplify Repeated Values

# locals {
#   instance_type = "t2.micro"
# }


# variable "ami_id" {
#     description = "The Type of AMI Id to use"
#     type = string
#     default = "ami-042e76978adeb8c48"
  
# }

# resource "aws_instance" "ec2-test-1" {
#     ami = var.ami_id
#     instance_type = local.instance_type
#     tags = {
#         Name = "test-ec2-1"
#     }
# }

# resource "aws_instance" "ec2-test-2" {
#     ami = var.ami_id
#     instance_type = local.instance_type
#     tags = {
#         Name = "test-ec2-2"
#     }
# }


# Using Locals with Complex Expressions

# locals {
#   enviornment ="dev"
#   region = "ap-northeast-2"
#   instance_type = "t2.micro"
#   instance_name = "test-instance-${local.enviornment}-${local.region}"
# }


# variable "ami_id" {
#     description = "The Type of AMI Id to use"
#     type = string
#     default = "ami-042e76978adeb8c48"
  
# }

# resource "aws_instance" "ec2-test" {
#     ami = var.ami_id
#     instance_type = local.instance_type
#     tags = {
#         Name = local.instance_name
#     }
# }


# Using Locals with Maps and Lists


# locals {
#   subnets = {
#     "subnet-1" = "10.0.1.0/24"
#     "subnet-2" = "10.0.2.0/24"
#     "subnet-3" = "10.0.3.0/24"
#   }
# }

# resource "aws_subnet" "example" {
#   for_each = local.subnets

#   cidr_block = each.value
#   vpc_id     = "vpc-9ff013f4"
#   availability_zone = "ap-northeast-2"
#   tags = {
#     Name = "subnet-${each.key}"
#   }
# }

# Assigning a Value Based on Environment

# locals {
#   enviornment ="dev"
#   region = "ap-northeast-2"
#   instance_type = local.enviornment == "prod" ? "t3.medium" : "t2.micro"
#   instance_name = "test-instance-${local.enviornment}-${local.region}"
# }


# variable "ami_id" {
#     description = "The Type of AMI Id to use"
#     type = string
#     default = "ami-042e76978adeb8c48"
  
# }

# resource "aws_instance" "ec2-test" {
#     ami = var.ami_id
#     instance_type = local.instance_type
#     tags = {
#         Name = local.instance_name
#     }
# }

# Create Multiple EC2 Instances Based on a List

# locals {
#   enviornment = "dev"
#   instance_type = local.enviornment == "prod" ? "t3.medium" : "t2.micro"
#   instance_names = ["web-server", "db-server", "cache-server"]
# }


# variable "ami_id" {
#     description = "The Type of AMI Id to use"
#     type = string
#     default = "ami-042e76978adeb8c48"
  
# }

# resource "aws_instance" "ec2-test" {
#     for_each = toset(local.instance_names)
#     ami = var.ami_id
#     instance_type = local.instance_type
#     tags = {
#         Name = each.key
#     }
# }


# Creating a Security Group with Dynamic Rules

locals {
  common_ports = [22, 80, 443]
  additional_ports = [8080, 3306]

  # Combine the two lists into one
  all_ports = concat(local.common_ports, local.additional_ports)
}

resource "aws_security_group" "test-sg-1" {
  name        = "test-sg"
  description = "Security group for test security group instances"
  vpc_id      = "vpc-9ff013f4"

  dynamic "ingress" {
    for_each = local.all_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
