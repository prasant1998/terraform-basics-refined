# resource "aws_instance" "test-ec2-delete" {
#   instance_type = "t2.micro"
#   ami           = "ami-042e76978adeb8c48"
#   tags = {
#     Name = "testdelete"
#   }

# }




removed {
  from = aws_instance.test-ec2-delete

  lifecycle {
    destroy = true
  }
  provisioner "local-exec" {
    when = destroy
    command = "echo 'Instance ${self.id} has been destroyed."
  }
}