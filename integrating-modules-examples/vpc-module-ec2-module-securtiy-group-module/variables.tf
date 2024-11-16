variable "vpc_name" {
  description = "VPC Name"
  type = string
  
}

variable "vpc_cidr" {
  description = "Cidr for VPC to be created"
  type = string
  
}

variable "azs" {
    description = "Availabilty Zones for the Subnets to be launched"
    type = list(string)
  
}

variable "private_subnets_cidr" {
    description = "CIDR for the Private Subnets"
    type = list(string)
  
}

variable "public_subnets_cidr" {
    description = "CIDR for the Public Subnets"
    type = list(string)
  
}



variable "sg_name" {
    description = "Name of the Security Group"
    type = string
  
}






variable "ami_id" {
    description = "AMI Id to be used to launch ec2 instance"
    type = string
  
}


variable "instance_type" {
    description = "Type of Instance to be used"
    type = string
  
}
