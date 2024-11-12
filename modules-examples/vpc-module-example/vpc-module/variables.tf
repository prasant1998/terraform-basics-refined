variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default = "173.10.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default = "test-vpc"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
  default = "173.10.0.0/20"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
  default = "173.10.16.0/20"
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
  default = "173.10.32.0/20"
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
  default = "173.10.64.0/20"
}

variable "availability_zone_1" {
  description = "Availability zone for the first subnet"
  type        = string
  default = "ap-northeast-2a"
}

variable "availability_zone_2" {
  description = "Availability zone for the second subnet"
  type        = string
  default = "ap-northeast-2c"
}