variable "sg_name" {
  description = "Security Group Name"
  type = string
  default = "test-sg"
  
}


variable "vpc_id" {
  description = "To be refrenced from the VPC Created"
  type = string
  
}

variable "ingress_rules" {
    description = "Security Group Ingress Rules"
    type = list(object({
      cidr_block = string
      to_port = number
      from_port = number
      protocol = string

    }))
    default = [ {
      cidr_block = "0.0.0.0/0"
      to_port = 80
      from_port = 80
      protocol = "tcp"
    },
    {
      cidr_block = "0.0.0.0/0"
      to_port = 443
      from_port = 443
      protocol = "tcp"
    } ]
  
}

variable "egress_rules" {
    description = "Security Group Egress Rule"
    type = list(object({
      cidr_block = string
      to_port = number
      from_port = number
      protocol = string 
    }))
    default = [ {
      cidr_block = "0.0.0.0/0"
      to_port = 0
      from_port = 0
      protocol = "-1"
    } ]
  
}