# Simple Example, Handling Missing Map Keys


# variable "map_test" {
#     type = map(string)
#     default = {
#       "test" = "fail"
#     }
# }

# output "map_test_output" {
#     value = try(var.map_test["test"], "default_value")
# }

#------------------------------------------------------------------------

# Handling Optional Resource Attributes

# resource "aws_security_group" "test-sg" {
#     name = "example-sg"
#     # description = "This is a test Security Group"
# }

# output "sg_description" {
#     value = try(aws_security_group.test-sg.description, "No Description available")
# }

#------------------------------------------------------------------------------------------

# Handling Missing Values in a List


# variable "fruits" {
#     type = list(string)
#     default = [ "apple", "banana", "cherry" ]
# }
# output "list_access_1" {
#     value = try(var.fruits[0], "Index 1 not found")
  
# }

# output "list_access_2" {
#     value = try(var.fruits[5], "Index out of bounds")
# }

# output "list_access_3" {
#     value = try(var.fruits[3], var.fruits[2], "Index  out of bounds")
# }

# output "list_access_4" {
#     value = try(var.fruits[5], var.fruits[4], "Index  out of bounds")
# }

#------------------------------------------------------------------------------------------

# Using try() with Module Outputs

module "test-module-try" {
    source = "./vpc-module"
  
}

output "module_output_with_try" {
    value = try(module.test-module-try.vpc_id, "Default value if module fails")
  
}
#------------------------------------------------------------------------------------------

