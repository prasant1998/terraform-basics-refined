# Simple Example

# variable "enable_feature" {
#     type = bool
#     default = true
  
# }

# output "feature_status" {
#     value = var.enable_feature ? "Feature is enabled" : "Feature is disabled"
  
# }


#---------------------------------------------------------------------------------

# Using Conditionals with count

# variable "create_instance" {
#     type = bool
#     default = false
  
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
#     count = var.create_instance ? 1 : 0
#     ami = var.ami_id
#     instance_type = var.instance_type
#     tags = {
#         Name = "test-ec2"
#     }
# }

# ----------------------------------------------------------------------------------

# Default Value for Security Group

# variable "enable_https" {
#     description = "Enable HTTPS security group rule"
#     type = bool
#     default = false
  
# }

# resource "aws_security_group" "test_sg" {
#     name = "test_sg"
#     description = "Test Security group"
#     ingress {
#         from_port = var.enable_https ? 443 : 80
#         to_port = var.enable_https ? 443 :80
#         protocol = "tcp"
#         cidr_blocks = [ "0.0.0.0/0" ]
#     } 
  
# }

# -------------------------------------------------------------------------------

# Creating resource conditionally

# variable "create_bucket" {
#     description = "Should we create an S3 bucket?"
#     type = bool
#     default = true
  
# }

# resource "aws_s3_bucket" "test_s3" {
#     count = var.create_bucket ? 1 : 0

#     bucket = "test-cx-bucket"
  
# }

# ------------------------------------------------------------------------------------

# Creating Conditional Outputs Based on a Map


# variable "allowed_enviornments" {
#     description = "List of allowed enviornments"
#     type = list(string)
#     default = [ "dev", "prod" ]
  
# }

# variable "enviornments" {
#     description = "Map of enviornments"
#     type = map(string)
#     default = {
#       "dev" = "Development"
#       "prod" = "Production"
#       "test" = "Testing"
#     }
  
# }

# output "deployed_envionments" {
#     value = { for env, name in var.enviornments : env => name if contains(var.allowed_enviornments, env)}
  
# }

# ----------------------------------------------------------------------------

# Setting Resource Tags Based on Conditions


# variable "env" {
#     description = "The enviornment to deploy to"
#     type = string
#     default = "test"
  
# }

# resource "aws_instance" "test_instance" {
#     ami = "ami-042e76978adeb8c48"
#     instance_type = "t2.micro"

#     tags = var.env == "prod" ? {
#         "Name" = "Production_Instance"
#         "Enviornment" = "Production"
#         "Owner" = "Prod Team"
#     } : var.env == "dev" ? {
#         "Name" = "Development_Instance"
#         "Enviornment" = "Development"
#         "Owner" = "Dev Team"
#     } : {
#         "Name" = "Unknown_Instance"
#         "Enviornment" = "Unknown"
#         "Owner" = "Unknown"
#     }
  
# }

# ----------------------------------------------------------------------------

# Dynamically Setting a Region for AWS Resources

# variable "enviornment" {
#     description = "The Enviornment to deploy to"
#     type = string
#     default = "test"
  
# }

# locals {
#   region = var.enviornment == "prod" ? "us-east-1" : var.enviornment == "dev" ? "us-west-1" : "us-east-2" 
# }

# provider "aws" {
#     alias = "region_alias"
#     region = local.region
  
# }

# resource "aws_s3_bucket" "test-region-bucket-cx" {
#     provider = aws.region_alias
#     bucket = "test-${local.region}"

  
# }

# --------------------------------------------------------------------------

variable "tags" {
    description = "Optional tags for resources"
    type = map(string)
    default = {}
  
}

resource "aws_instance" "test_instance" {
    ami = "ami-042e76978adeb8c48"
    instance_type = "t2.micro"

    tags = merge(
        {
            "Name" = "MyInstance"
        },
        var.tags != {} ? var.tags : {
            "Enviornment" = "Test_Env"
        }
    )
  
}