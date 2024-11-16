output "Instance_id" {
    description = "Id of the Created EC2 Insṭance"
    value = aws_instance.test-module-ec2.id
  
}

output "ami_id" {
    description = "Check Ami_id"
    value = aws_instance.test-module-ec2.ami
  
}