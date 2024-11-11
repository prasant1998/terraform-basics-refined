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
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = "test-ec2"
    }
}

output "instance_id" {
    value = aws_instance.ec2-test.id
  
}