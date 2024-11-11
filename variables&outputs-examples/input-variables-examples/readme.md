In Terraform, input variables allow us to customize configurations and make them more reusable. Instead of hardcoding values, we define variables that can be set when we run our Terraform code. This makes it easy to deploy the same infrastructure in different environments with different settings.

# Basic Variable Declaration

The variable blocks define inputs for the Terraform configuration. We can think of these as "parameters" that can be passed in when running Terraform.

instance_type and ami_id are both parameters that allow us to customize the EC2 instance that will be created.

The values of these variables (var.instance_type and var.ami_id) are then used in the aws_instance resource. By doing this, the configuration becomes flexible and reusable.

# Number Variable

count = var.instance_count:

The count meta-argument is used to create multiple instances of the aws_instance resource.

ami = var.ami_id:

This line sets the AMI ID for the instances. It uses the value of var.ami_id, which is the ID of the AMI (Amazon Machine Image) to use for the EC2 instances.

instance_type = var.instance_type:

This line sets the EC2 instance type (e.g., t2.micro, t3.medium, etc.) for the instances. It uses the value of var.instance_type, which is t2.micro by default.

tags = { Name = "test-ec2-${count.index}" }:

tags is used to assign tags to the EC2 instances. Tags are useful for identifying and organizing resources in AWS.

The Name tag is set to "test-ec2-${count.index}".

${count.index} is a special variable that gets the index of the current instance in the list of instances being created. It’s important to note that count.index is zero-based, meaning it starts from 0 for the first instance, 1 for the second, and so on.

This helps to uniquely identify each EC2 instance, especially when multiple instances are created.

# List Variable

Creates Multiple Instances:

The count argument makes the configuration flexible and scalable. By using length(var.availability_zones), it ensures that the number of EC2 instances created matches the number of availability zones in the list. 

The availability_zone for each instance is determined by the value at the current index in the availability_zones list, thanks to the count.index variable. 

The instances are tagged with a Name that includes their respective availability zone.

# map variable

tags = var.instance_tags: 
This applies the tags to the EC2 instance. The tags are taken from the instance_tags variable, which is a map of key-value pairs:

"Name" = "test-instance"
"Env" = "dev"
"Owner" = "Prasant"

These tags will be applied to the EC2 instance when it is created. Tags are helpful for managing, identifying, and organizing resources in AWS.


# Using an Object to Manage AWS VPC Configuration



Creating a VPC that includes:

A CIDR block for the network.
A list of availability zones.
A set of subnets with different types (public and private).
Tags to help identify the VPC.

We will be using an object variable to pass all of this configuration to the resource.

vpc_config is an object containing:

cidr_block: 
A string representing the CIDR block for the VPC (e.g., "10.0.0.0/16").
availability_zones: 
A list of availability zones (e.g., ["ap-northeast-2a", "ap-northeast-2c"]).
subnets:
A list of objects, each representing a subnet with its name, CIDR block, and type (public or private).
tags: 
A map of key-value pairs representing the tags to apply to the VPC.

Now, 

The aws_vpc resource uses var.vpc_config.cidr_block and var.vpc_config.tags to create the VPC and assign tags.

The aws_subnet resources use the for_each meta-argument to loop over the list of subnets defined in the vpc_config.subnets object. We filter the subnets by their type (public or private) and assign them to different resources.

Each subnet resource will use each.value.subnet_cidr and each.value.subnet_name to assign the CIDR block and name, respectively.

The availability_zone is selected from the list of availability zones using the element function. For example, the first subnet gets ap-northeast-2a, and the second one gets ap-northeast-2c.

For the Output,

The CIDR block of the VPC.
The tags assigned to the VPC.
A list of subnet names (e.g., ["public-subnet-1", "private-subnet-1"]).


The vaiables defined should be in the variables.tf file, but for practice I have done all in one file.

We can override the default values by creating a terraform.tfvars file or passing them through the command line. But passing through command line is not suggested.




Breaking Down the line 


for_each = { for idx, subnet in var.vpc_config.subnets : subnet.subnet_name => subnet if subnet.subnet_type == "public" }


The for_each Meta-argument:

for_each is iterating over the list of subnets, var.vpc_config.subnets, and creating multiple aws_subnet resources for each subnet in the list that matches the criteria (subnet_type == "public"), same for the private.

The for Expression:

var.vpc_config.subnets is a list of objects, where each object represents a subnet and has properties like subnet_name, subnet_cidr, and subnet_type.

idx is the index of the element in the list (though not used in this particular example, it's available if we want to use it).

subnet represents the current element (an object) in the list var.vpc_config.subnets during each iteration.

subnet.subnet_name => subnet: This part is creating a map from each subnet's subnet_name to the subnet object itself.

    This means that each subnet will be indexed by its subnet_name, which makes it easy to refer to each subnet by its name in subsequent references within the resource block.

    The subnet_name is used as the key, and the entire subnet object is used as the value.

This if condition filters the subnets. It means only subnets where subnet_type is "public" will be included in the iteration. So, only the public subnets (those where subnet.subnet_type == "public") will be created as resources.


for_each expression will create a map of the form:



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



Private Subnet Line is identical to the public subnet line, except it only iterates over subnets where subnet_type == "private".

Using subnet_name as the key allows Terraform to manage each subnet resource individually, so we can easily refer to and manage each subnet.



element(var.vpc_config.availability_zones, 0)



The element() function in Terraform is used to retrieve an element from a list based on its index.
element(list, index)

list: The list (or array) from which we want to retrieve an element.
index: The zero-based index of the element we want to retrieve.

element(var.vpc_config.availability_zones, 0) retrieves the first availability zone in the list availability_zones (e.g., "ap-northeast-2a").