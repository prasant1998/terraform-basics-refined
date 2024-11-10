# If We need to create multiple IAM users, each with a unique name:


# variable "user_names" {
#   type    = set(string)
#   default = ["ram", "shyam", "happy"]
# }

# resource "aws_iam_user" "devops_user" {
#   for_each = var.user_names
  
#   name = each.key
# }

# For each user requires a specific role, we can use a map to specify both names and roles:

# variable "users_with_roles" {
#   type    = map(string)
#   default = {
#     ram   = "developer",
#     shyam  = "developer",
#     happy = "Admin"
#   }
# }

# resource "aws_iam_user" "devops_user" {
#   for_each = var.users_with_roles

#   name = each.key
#   tags = {
#     Role = each.value
#   }
# }


#for_each can work with more complex data, such as maps of objects. Let’s say we need to create security groups with custom rules:

variable "security_groups" {
  type = map(object({
    description = string
    ingress_ports = list(number)
  }))
  default = {
    web = {
      description   = "Web Server Security Group"
      ingress_ports = [80, 443]
    },
    db = {
      description   = "Database Security Group"
      ingress_ports = [5432]
    }
  }
}

resource "aws_security_group" "sg" {
  for_each    = var.security_groups
  name        = each.key
  description = each.value.description

  tags = {
    "Name" = each.key
  }

  dynamic "ingress" {
    for_each = each.value.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
