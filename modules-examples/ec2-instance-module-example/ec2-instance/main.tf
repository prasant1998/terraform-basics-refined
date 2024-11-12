resource "aws_instance" "module-test" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
      "Name" = var.instance_name
    }
  
}