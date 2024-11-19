# Removing Duplicate CIDR Blocks in Security Group Ingress Rules


# variable "cidr_blocks" {
#     description = "A list of CIDR Blocks"
#     type = list(string)
#     default = [ "10.0.0.0/24", "10.0.0.0/24", "192.168.0.0/24" ]

  
# }

# resource "aws_security_group" "test-sg" {
#     name = "test-sg"
#     description = "test security group"

#     dynamic "ingress" {
#         for_each = toset(var.cidr_blocks)

#         content {
#           from_port = 80
#           to_port = 80
#           protocol = "tcp"
#           cidr_blocks = [ ingress.key ]
#         }
      
#     }
  
# }


# output "unique_cidr_blocks" {
#     value = [ for cidr in aws_security_group.test-sg.ingress : cidr.cidr_blocks]
  
# }

# -------------------------------------------------------------------------------------

# Ensuring Unique tags

variable "tags" {
    description = "A list of tags"
    type = list(string)
    default = [ "Enviornment=dev", "Enviornment=dev", "Project=Terraform" ]
  
}

resource "aws_instance" "test_instance" {
    ami = "ami-042e76978adeb8c48"
    instance_type = "t2.micro"
    tags = {for tag in toset(var.tags) : split("=", tag)[0] => split("=", tag)[1] }
  
}

output "unique_tags" {
    value = aws_instance.test_instance.tags
  
}

