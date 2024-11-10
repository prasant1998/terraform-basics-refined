
resource "aws_instance" "name" {

    count = 3 # it creates 3 types of similiar instances.
    ami = "ami-042e76978adeb8c48"
    instance_type = "t2.micro"
    tags = {
        Name = "Server- ${count.index}"
    }
}


