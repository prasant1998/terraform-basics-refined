variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type = string
    default = "ami-042e76978adeb8c48"
  
}

variable "instance_type" {
    description = "Type of Instance to be used"
    type = string
    default = "t2.micro"
  
}

variable "instance_name" {
    description = "The Instance Name of the EC2 Instance"
    type = string
    default = "Test-Ec2"
  
}

variable "subnet_id" {
    description = "The subnet id to be used by instance"
    type = string
  
}