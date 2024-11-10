data "aws_ami" "condition_check" {
    most_recent = true
    owners = ["099720109477"]
    filter {
      name = "image-id"
      values = ["ami-096099377d8850a97"]
    }
  
}


resource "aws_instance" "condition_check" {
    ami = data.aws_ami.condition_check.id
    instance_type = "t2.micro"
    tags = {
      "Name" = "condition-check"
    }

    lifecycle {
      precondition {
        condition = data.aws_ami.condition_check.architecture == "x86_64"
        error_message = "The AMI Used must be x86 arch"
      }
    }
  
}