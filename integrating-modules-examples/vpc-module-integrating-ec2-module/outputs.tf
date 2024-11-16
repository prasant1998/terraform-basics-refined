output "check_ami_id" {
    value = module.ec2_instance.ami_id
  
}

output "check_data_ami" {
    value = data.aws_ami.latest_amazon.id
  
}

output "instance_id" {
    value = module.ec2_instance.Instance_id
  
}