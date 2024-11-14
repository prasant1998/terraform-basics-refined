# Dynamic Security Group Ingress Rules

# variable "ingress_rules" {
#     description = "List of Ingress Rule"
#     type = list(object({
#       cidr_block = string
#       from_port = number
#       to_port = number
#       protocol = string 
#     }))
#     default = [ {
#       cidr_block = "0.0.0.0/0"
#       from_port =  22
#       to_port = 22
#       protocol = "tcp"
#     },
#     {
#       cidr_block = "192.168.1.0/24"
#       from_port = 80
#       to_port = 80
#       protocol = "tcp"
#     } ]
  
# }

# resource "aws_security_group" "test-sg" {
#     name = "test-sg"
#     description = "Test Security Group"

#     dynamic "ingress" {
#         for_each = var.ingress_rules
#         content {
#           from_port = ingress.value.from_port
#           to_port = ingress.value.to_port
#           protocol = ingress.value.protocol
#           cidr_blocks = [ ingress.value.cidr_block ]
#         }
      
#     }
  
# }

#--------------------------------------------------------------------------------------------

# Dynamic Ingress and Egress Rules for AWS Security Group

variable "ingress_rules" {
    description = "List of Ingress rules"
    type = list(object({
      cidr_block = string
      from_port = number
      to_port = number
      protocol= string 
    }))
    default = [ {
      cidr_block = "0.0.0.0/0"
      from_port = 22
      to_port = 22
      protocol = "tcp"
    },
    {
      cidr_block = "10.0.0.0/16"
      from_port = 80
      to_port = 80
      protocol = "tcp"
    } ]

  
}

variable "egress_rules" {
    description = "List of Egress rules"
    type = list(object({
      cidr_block = string
      from_port = number
      to_port = number
      protocol= string 
    }))
    default = [ 
    {
      cidr_block = "0.0.0.0/0"
      from_port = 0
      to_port = 0
      protocol = "-1"
    } ]

  
}

resource "aws_security_group" "test-sg" {
    name = "test-sg"
    description = "Security Group with dynamic ingress and egress rule"

    dynamic "ingress" {
        for_each = var.ingress_rules
        content {
          cidr_blocks = [ingress.value.cidr_block]
          to_port = ingress.value.to_port
          from_port = ingress.value.from_port
          protocol = ingress.value.protocol
        }
      
    }

    dynamic "egress" {
        for_each = var.egress_rules
        content {
          cidr_blocks = [egress.value.cidr_block]
          to_port = egress.value.to_port
          from_port = egress.value.from_port
          protocol = egress.value.protocol
        }
      
    }
  
}







#--------------------------------------------------------------------------------------------

# Dynamic IAM User Policies

# variable "iam_users" {
#     description = "List of Iam users and their policies"
#     type = list(object({
#       user_name = string
#       policies = list(string)
#     }))
#     default = [ {
#       user_name = "ram"
#       policies = [ "arn:aws:iam::aws:policy/AdministratorAccess" ]
#     },
#     {
#       user_name = "shyam"
#       policies = [ "arn:aws:iam::aws:policy/ReadOnlyAccess", "arn:aws:iam::aws:policy/EC2FullAccess" ]
#     } ]
  
# }

# resource "aws_iam_user" "example" {
#   for_each = { for u in var.iam_users : u.user_name => u }

#   name = each.key

#   dynamic "policy" {
#     for_each = each.value.policies
#     content {
#       name   = "policy-${policy.value}"
#       policy = policy.value
#     }
#   }
# }

#### Dynamic is not applicable here 


# --------------------------------------------------------------------------------------





