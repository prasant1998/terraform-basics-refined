variable "vpc_config" {
  description = "Configuration for the AWS VPC and associated resources"
  type = object({
    cidr_block = string
    availability_zones = list(string)
    subnets = list(object({
      subnet_name = string
      subnet_cidr = string
      subnet_type = string 
    })) 
    tags = map(string)
  })
  default = {
    cidr_block = "173.10.0.0/16"
    availability_zones = [ "ap-northeast-2a", "ap-northeast-2c" ]
    subnets = [ {
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
    } ]
    tags = {
      "Name" = "test-vpc"
      "kubernetes.io/cluster/eks-cluster" = "shared"
      "kubernetes.io/role/internal-elb" = 1
      "Env"  =  "env"
    }
  }
}

variable "env" {
  description = "Enviornment for the Infrastructure"
  type = string
  
}
variable "private_subnet_tags" {
  description = "Tags for the private subnets"
  type = map(string)
}

variable "public_subnet_tags" {
  description = "Tags for the public subnets"
  type = map(string)
}