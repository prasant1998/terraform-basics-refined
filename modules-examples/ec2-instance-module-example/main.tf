module "module-test" {
    source = "./ec2-instance"
    # Here it would overwrite the variable values.
    ami_id = "ami-042e76978adeb8c48"
    instance_type = "t3.medium"
    instance_name = "overwrite-module-test"
  
}

output "instance_id" {
    value = module.module-test.instance_id
  
}