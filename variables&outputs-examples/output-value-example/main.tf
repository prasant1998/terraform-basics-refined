# Output EC2 Instance ID

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
#     ami = var.ami_id
#     instance_type = var.instance_type
#     tags = {
#         Name = "test-ec2"
#     }
# }

# output "ec_instance_id" {
#     value = aws_instance.ec2-test.id
#     description = "The id of the created EC2 instance"
  
# }

# Output Multiple Values (IP Address & Instance ID)

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
#     ami = var.ami_id
#     instance_type = var.instance_type
#     tags = {
#         Name = "test-ec2"
#     }
# }

# output "ec2_instance_id" {
#     value = aws_instance.ec2-test.id
#     description = "The id of the created EC2 instance"
  
# }

# output "ec2_public_ip" {
#     value = aws_instance.ec2-test.public_ip
#     description = "The public ip of the created EC2 instance"
  
# }

# Using Sensitive Outputs


resource "random_password" "random_pass" {
    length = 16
    special = true
}

output "random_pass" {
    value = random_password.random_pass.result
    sensitive = true
    description = "Password generated"
  
}





