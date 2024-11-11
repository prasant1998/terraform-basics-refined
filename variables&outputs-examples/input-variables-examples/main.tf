# Basic Variable Declaration

# variable "instance_type" {
#   description = "The type of instance to use"
#   type        = string
#   default     = "t2.micro"
# }

# variable "ami_id" {
#     description = "The Type of AMI Id to use"
#     type = string
#     default = "ami-042e76978adeb8c48"
  
# }

# resource "aws_instance" "ec2-test" {
#     ami = var.ami_id
#     instance_type = var.instance_type
#     tags = {
#         Name = "test-ec2"
#     }
# }

#-----------------------------------------------------------------------------

#Number Variable

# variable "instance_count" {
#     description = "Count for the Instance"
#     type = number
#     default = 2
  
# }

# variable "instance_type" {
#   description = "The type of instance to use"
#   type        = string
#   default     = "t2.micro"
# }

# variable "ami_id" {
#     description = "The Type of AMI Id to use"
#     type = string
#     default = "ami-042e76978adeb8c48"
# }

# resource "aws_instance" "ec2-test" {
#     count = var.instance_count
#     ami = var.ami_id
#     instance_type = var.instance_type
#     tags = {
#         Name = "test-ec2-${count.index}"
#     }
# }

#--------------------------------------------------------------------------------------------

#List Variable

# variable "availability_zones" {
#     description = "List of availability zones"
#     type = list(string)
#     default = ["ap-northeast-2a", "ap-northeast-2c"]
  
# }

# variable "instance_type" {
#   description = "The type of instance to use"
#   type        = string
#   default     = "t2.micro"
# }

# variable "ami_id" {
#     description = "The Type of AMI Id to use"
#     type = string
#     default = "ami-042e76978adeb8c48"
# }

# resource "aws_instance" "ec2-test" {
#     count = length(var.availability_zones)
#     availability_zone = var.availability_zones[count.index]
#     ami = var.ami_id
#     instance_type = var.instance_type
#     tags = {
#         Name = "Instance in- ${var.availability_zones[count.index]}"
#     }
# }

#--------------------------------------------------------------------------------

#map variable

variable "instance_tags" {
    description = "A map of tags to apply to ec2 instance"
    type = map(string)
    default = {
      "Name" = "test-instance"
      "Env" = "dev"
      "Owner" = "Prasant" 
    }
  
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
    description = "The Type of AMI Id to use"
    type = string
    default = "ami-042e76978adeb8c48"
}

resource "aws_instance" "ec2-test" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = var.instance_tags
}

output "instance_tags" {
    value = var.instance_tags
  
}

#---------------------------------------------------------------------------------------------

#object Variable

# Using an Object to Manage AWS VPC Configuration

variable "vpc_config" {
    description = "Configuration for the AWS VPC and associated resources"
    type = object({
      cidr_block = string
      availability_zones = list(string)
      subnets   = list(object({
        subnet_name = string 
        subnet_cidr = string
        subnet_type = string
      }))
      tags = map(string)
    })
  default = {
    cidr_block = "10.0.0.0/16"
    availability_zones = [ "ap-northeast-2a", "ap-northeast-2c" ]
    subnets = [ {
      subnet_name = "public-subnet-1"
      subnet_cidr = "10.0.1.0/24"
      subnet_type = "public"
    },
    {
        subnet_name = "private-subnet-1"
        subnet_cidr = "10.0.2.0/24"
        subnet_type = "private"
    } ]
    tags = {
      "Name" = "testVPC"
      "Env" = "dev"
      "Owner" = "Prasant"
    }
  }
}

resource "aws_vpc" "testvpc" {
    cidr_block = var.vpc_config.cidr_block
    tags = var.vpc_config.tags
  
}


resource "aws_subnet" "testsubnetpublic" {
  for_each = { for idx, subnet in var.vpc_config.subnets : subnet.subnet_name => subnet if subnet.subnet_type == "public" }

  vpc_id            = aws_vpc.testvpc.id
  cidr_block        = each.value.subnet_cidr
  availability_zone = element(var.vpc_config.availability_zones, 0)  # Assign the first AZ from the list
  map_public_ip_on_launch = true
  tags = merge(
    var.vpc_config.tags,
    { "Name" = each.value.subnet_name }
  )
}

resource "aws_subnet" "testsubnetprivate" {
  for_each = { for idx, subnet in var.vpc_config.subnets : subnet.subnet_name => subnet if subnet.subnet_type == "private" }

  vpc_id            = aws_vpc.testvpc.id
  cidr_block        = each.value.subnet_cidr
  availability_zone = element(var.vpc_config.availability_zones, 1)  # Assign the second AZ from the list
  map_public_ip_on_launch = false
  tags = merge(
    var.vpc_config.tags,
    { "Name" = each.value.subnet_name }
  )
}

output "vpc_cidr" {
  value = var.vpc_config.cidr_block
}

output "vpc_tags" {
  value = var.vpc_config.tags
}

output "subnet_names" {
  value = [for subnet in var.vpc_config.subnets : subnet.subnet_name]
}
