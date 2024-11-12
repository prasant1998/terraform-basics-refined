# A VPC Module

```
vpc-module-example/
├── main.tf            # Root module (calls the VPC module)
├── vpc-module/        # Module directory
│   ├── main.tf        # VPC module definition
│   ├── variables.tf   # VPC module variables
│   └── outputs.tf     # VPC module outputs

```


Defined a module with the following resources:

VPC: 
The core network.

Public Subnets: 
Two subnets in different availability zones (AZs) for high availability.

Private Subnets: 
Two private subnets for backend services.

Internet Gateway: 
For public subnet internet access.

In the root main.tf, :

Referenced the vpc-module by specifying the path to the module (source = "./vpc-module").


Output the VPC and subnet IDs from the module for easy reference.


# Breaking Down the line

for_each = { for idx, subnet in var.vpc_config.subnets : subnet.subnet_name => subnet if subnet.subnet_type == "public" }

# The for_each Meta-argument:

for_each is iterating over the list of subnets, var.vpc_config.subnets, and creating multiple aws_subnet resources for each subnet in the list that matches the criteria (subnet_type == "public"), same for the private.

# The for Expression:

var.vpc_config.subnets is a list of objects, where each object represents a subnet and has properties like subnet_name, subnet_cidr, and subnet_type.

idx is the index of the element in the list (though not used in this particular example, it's available if we want to use it).

subnet represents the current element (an object) in the list var.vpc_config.subnets during each iteration.

subnet.subnet_name => subnet: This part is creating a map from each subnet's subnet_name to the subnet object itself.

This means that each subnet will be indexed by its subnet_name, which makes it easy to refer to each subnet by its name in subsequent references within the resource block.

The subnet_name is used as the key, and the entire subnet object is used as the value.

This if condition filters the subnets. It means only subnets where subnet_type is "public" will be included in the iteration. So, only the public subnets (those where subnet.subnet_type == "public") will be created as resources.

# for_each expression will create a map of the form:

```

{
  "public-subnet-1" = {
    subnet_name = "public-subnet-1"
    subnet_cidr = "10.0.1.0/24"
    subnet_type = "public"
  },
  "public-subnet-2" = {
    subnet_name = "public-subnet-2"
    subnet_cidr = "10.0.3.0/24"
    subnet_type = "public"
  }
}

```


Private Subnet Line is identical to the public subnet line, except it only iterates over subnets where subnet_type == "private".

Using subnet_name as the key allows Terraform to manage each subnet resource individually, so we can easily refer to and manage each subnet.

```
each.key == "public-subnet-1" ? 0 : 1

```


If each.key is "public-subnet-1", the expression will evaluate to 0, meaning the first availability zone (var.vpc_config.availability_zones[0]) will be chosen for the first public subnet.

If each.key is "public-subnet-2", the expression will evaluate to 1, meaning the second availability zone (var.vpc_config.availability_zones[1]) will be chosen for the second public subnet.