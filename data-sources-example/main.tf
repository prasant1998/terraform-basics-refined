#Retrieving an Existing VPC by Name

# data "aws_vpc" "test_vpc" {
#     filter {
#       name = "tag:Name"
#       values = ["test"]
#     }
  
# }

# resource "aws_subnet" "test-subnet" {
#     vpc_id = data.aws_vpc.test_vpc.id
#     cidr_block = "172.31.7.0/24"
  
# }

# --------------------------------------------------------------------------------------------------------

#Using a Data Source for Latest AMI

# data "aws_ami" "latest_amazon" {
#     most_recent = true
#     owners = ["amazon"]

#     filter {
#       name = "name"
#       values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#     }
  
# }

# variable "instance_type" {
#     type = string
#     default = "t2.micro"
  
# }

# resource "aws_instance" "test-ec2" {
#     instance_type = var.instance_type
#     ami = data.aws_ami.latest_amazon.id

#     tags = {
#         "Name" = "test-data-ec2"
#     }

#     lifecycle {
#       prevent_destroy = false
#     }
  
# }

#Getting Information from Another AWS Region

provider "aws" {
    alias = "us_east_1"
    region = "us-east-1"
}

data "aws_security_group" "test-sg" {
    provider = aws.us_east_1
    filter {
      name = "group-name"
      values = ["default"]
    }
    filter {
      name = "tag:env"
      values = ["test"]
    }
}

variable "ami_id" {
    type = string
    default = "ami-042e76978adeb8c48"
  
}

variable "instance_type" {
    type = string
    default = "t2.micro"
  
}

resource "aws_instance" "test-sg-ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    security_groups = [data.aws_security_group.test-sg.name]

    tags = {
        "Name" = "test-ec2"
    }

    lifecycle {
      prevent_destroy = false
    }
  
}