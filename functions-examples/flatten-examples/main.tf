#  Flattening a List of Maps with Subnets

# variable "regions" {
#     description = "List pof regions with associated subnets"
#     type = list(object({
#       region = string
#       subnets = list(object({
#         id = string
#         cidr =string
#       })) 
#     }))
#     default = [ {
#       region  = "us-east-1"
#       subnets = [
#         { id = "subnet-1", cidr = "10.0.0.0/24" },
#         { id = "subnet-2", cidr = "10.0.1.0/24" }
#       ]
#     },
#     {
#       region  = "us-west-2"
#       subnets = [
#         { id = "subnet-3", cidr = "10.1.0.0/24" },
#         { id = "subnet-4", cidr = "10.1.1.0/24" }
#       ]
      
#     } ]
  
# }

# output "flattened_subnet" {
#     value = flatten([for region in var.regions : region.subnets ])
  
# }

# -------------------------------------------------------------------------------------

 # Conditionally Include Subnets Based on a Flag

 variable "include_subnets" {
  description = "Flag to include subnets for a region"
  type        = map(bool)
  default     = {
    "us-east-1" = true
    "us-west-2" = false
  }
}

variable "region_subnets" {
  description = "Map of region to subnets"
  type        = map(list(string))
  default     = {
    "us-east-1" = ["subnet-1", "subnet-2"],
    "us-west-2" = ["subnet-3", "subnet-4"]
  }
}

output "enabled_subnets" {
  value = flatten([for region, include in var.include_subnets : 
    include ? var.region_subnets[region] : [] ])
}
