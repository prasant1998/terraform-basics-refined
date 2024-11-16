output "Vpc_id" {
    value = module.vpc.default_vpc_id
  
}

output "vpc_id" {
    value = module.vpc.vpc_id
  
}


output "sg_id" {
    value = module.sg-module.sg_id
  
}

output "instance_id" {
    value = module.ec2-instance.id
  
}