# Dynamically Create EC2 Instances in Multiple Regions


# variable "regions" {
#     type = map(string)
#     default = {
#       "us-east-1a" = "t2.micro"
#       "us-west-1b" = "t2.small"
#       "eu-west-1c" = "t2.medium"
#     }
  
# }


# resource "aws_instance" "test_instance" {
#     for_each = var.regions

#     ami = "ami-042e76978adeb8c48"
#     instance_type = each.value
#     availability_zone = each.key
  
# }

# output "instance_id" {
#     value = { for region, instance in aws_instance.test_instance : region => instance.id }
  
# }

# Wrong Method, Not working  


#-------------------------------------------------------------------------------


# Filter Instances by Tags and Modify Data

# variable "instances" {
#     type = list(object({
#       id = string
#       tags =map(string) 
#     }))
#     default = [ 
#       { id = "i-123" , tags = { "Enviornment" = "dev", "Name" = "Instance 1" } },
#       { id = "i-456", tags = { "Enviornment" = "prod", "Name" = "Instance 2" } },
#       { id= "i-789", tags = { "Enviornment" = "dev", "Name" = "Instance 3" } }
#     ]
  
# }

# output "dev_instance_ids" {
#     value = [for instance in var.instances : instance.id if instance.tags["Enviornment"] == "dev"]
  
# }


#-----------------------------------------------------------------------------------------

# Convert a List of Subnets into a Map

# variable "subnets" {
#     description = "List of Subnets"
#     type = list(object({
#       name = string
#       cidr = string
#     }))
#     default = [
#       { name = "subnet-1", cidr = "10.0.1.0/24"},
#       { name = "subnet-2", cidr = "10.0.2.0/24"},
#       { name = "subnet-3", cidr = "10.0.3.0/24"}
#     ]
  
# }
# output "subnet_group" {
#     value = { for subnet in var.subnets : subnet.name => subnet.cidr }
  
# }

# # Flatten a List of Lists

variable "subnets_by_region" {
    description = "Lists of subnet for each region"
    type = list(object({
      region = string
      subnets = list(string) 
    }))
    default = [
      {region = "us-east-1", subnets = [ "subnet-1", "subnet-2" ]},
      {region = "us-west-2", subnets = [ "subnet-3", "subnet-4" ]}
    ]
  
}

output "all_subnets" {
    value = flatten([ for region in var.subnets_by_region : region.subnets ])
  
}