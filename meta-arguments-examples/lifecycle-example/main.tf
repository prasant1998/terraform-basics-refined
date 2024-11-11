variable "ami_id" {
    type = string
    default = "ami-042e76978adeb8c48"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
  
}

resource "aws_instance" "test-lifecycle" {
  ami           = var.ami_id
  instance_type = var.instance_type

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
    ignore_changes        = [tags.test]
  }

  tags = {
    Name = "test2"
    test = "test3"
  }
}
