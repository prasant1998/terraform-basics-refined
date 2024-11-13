
# Get the instance type for the current environment.

# variable "environment" {
#     type = string
#     default = "dev"
  
# }

# locals {
#     instance_types = {
#         "dev" = "t2.micro"
#         "staging" = "t2.small"
#         "prod" = "t2.large"
#     } 
# }

# variable "ami_id" {
#     description = "The Type of AMI Id to use"
#     type = string
#     default = "ami-042e76978adeb8c48"
# }

# resource "aws_instance" "ec2-test" {
#     ami = var.ami_id
#     instance_type = lookup(local.instance_types, var.environment, "t3.medium")
#     tags = {
#         Name = "test-ec2"
#     }
# }

# output "instance_type" {
#     value = lookup(local.instance_types, var.environment, "t3.medium")
  
# }

# ---------------------------------------------------------------------------------------

# locals {
#   security_groups = {
#     "us-east-1" = {
#       "sg_web"   = "sg-12345"
#       "sg_db"    = "sg-67890"
#     }
#     "us-west-1" = {
#       "sg_web"   = "sg-abcde"
#       "sg_db"    = "sg-fghij"
#     }
#   }
# }

# output "web_sg_id" {
#     value = lookup(lookup(local.security_groups, "us-west-1", {}), "sg_web", "sg-default-id")
  
# }

# output "non_existing_sg" {
#   value = lookup(lookup(local.security_groups, "us-east-2", {}), "sg_web", "sg-default-id")
# }

# ---------------------------------------------------------------------------------------

# variable "config" {
#     type = map(string)
#     default = {
#       "instance_type" = "t2.micro"
#       "ami" = "ami-042e76978adeb8c48"
#     }
  
# }

# resource "aws_instance" "ec2-test" {
#     ami = lookup(var.config, "ami", "ami-042e76978adeb8c48")
#     instance_type = lookup(var.config, "instance_type", "t2.micro")
#     tags = {
#         Name = "test-ec2"
#     }
# }


# output "instance_type" {
#   value = lookup(var.config, "instance_type", "t2.micro")
# }

# ---------------------------------------------------------------------------------------

# Managing Multi-Environment Infrastructure

variable "environment" {
    type = string
    default = "dev"
  
}
locals {
  environment_configs = {
    "dev" = {
      "instance_type"  = "t2.micro"
      "subnet_id"      = "subnet-60322f08"
      "security_groups" = ["sg-31d6305d"]
      "ami_id"          = "ami-042e76978adeb8c48"
      "tags" = {
        "Name"        = "Dev Instance"
        "Environment" = "Dev"
      }
    }
    "staging" = {
      "instance_type"  = "t2.small"
      "subnet_id"      = "subnet-60322f08"
      "security_groups" = ["sg-31d6305d"]
      "ami_id"          = "ami-042e76978adeb8c48"
      "tags" = {
        "Name"        = "Staging Instance"
        "Environment" = "Staging"
      }
    }
    "prod" = {
      "instance_type"  = "t2.large"
      "subnet_id"      = "subnet-60322f08"
      "security_groups" = ["sg-31d6305d"]
      "ami_id"          = "ami-042e76978adeb8c48"
      "tags" = {
        "Name"        = "Production Instance"
        "Environment" = "Prod"
      }
    }
  }
}

locals {
  selected_config = lookup(local.environment_configs, var.environment, {})
}

resource "aws_instance" "test-lookup-instance" {
    ami = lookup(local.selected_config, "ami_id", "ami-042e76978adeb8c48")
    instance_type = lookup(local.selected_config, "instance_type", "t2.micro")
    subnet_id = lookup(local.selected_config, "subnet_id", ["sg-31d6305d"])
    security_groups = lookup(local.selected_config, "security_groups", ["sg-31d6305d"])
    tags = lookup(local.selected_config, "tags", {
        "Name"        = "Deafult Instance"
        "Environment" = "Default"
    })
  
}

output "selected_instance_type" {
  value = lookup(local.selected_config, "instance_type", "t2.micro")
}

output "selected_subnet_id" {
  value = lookup(local.selected_config, "subnet_id", ["sg-31d6305d"])
}

output "selected_tags" {
  value = lookup(local.selected_config, "tags", {
    "Name"        = "Default Instance"
    "Environment" = "Default"
  })
}