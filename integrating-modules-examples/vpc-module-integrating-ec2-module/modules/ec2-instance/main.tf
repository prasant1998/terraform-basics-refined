resource "aws_instance" "test-module-ec2" {
    instance_type = var.instance_type
    ami = var.ami_id
    subnet_id = var.subnet_id

    tags = {
      "Name" = var.instance_name
    }
  
}