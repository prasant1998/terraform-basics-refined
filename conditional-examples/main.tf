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

variable "create_instance" {
    type = bool
    default = false
  
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
    count = var.create_instance ? 1 : 0
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = "test-ec2"
    }
}