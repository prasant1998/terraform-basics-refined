# resource "aws_instance" "remove-instance1" {
#   ami           = "ami-042e76978adeb8c48"
#   instance_type = "t2.micro"

#   tags = {
#     "Name" = "test-delete"
#   }
# }


# resource "aws_s3_bucket" "test-delete" {
#   bucket = "test-delete-tf-bucket"
#   tags = {
#     Name = "mybuckets3"
#   }
# }


 removed {
   from = aws_s3_bucket.test-delete

   lifecycle {
     destroy = false
   }
 }
