
# Using Outputs to Reference Resources Across Configurations




module "compute" {
    source = "./compute"
  
}

output "instance_id_from_module" {
    value = module.compute.instance_id
}