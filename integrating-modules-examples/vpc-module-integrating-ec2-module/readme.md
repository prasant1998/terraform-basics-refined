# Module for setting up both VPC (Sourced from Terraregistry) and EC2 instances (Sources from Local), Combined them to create a module according to our requirement.

Importing the vpc module from the terraform-aws-modules/vpc/aws repository.
The version of the module is specified (5.15.0).

Providing configuration variables that the module requires (like name, cidr, subnets-details etc.).

Custom Module to Create an EC2 Instance

Created our own custom module to encapsulate certain reusable infrastructure code.

Combined External Modules with Custom Modules"

The vpc module is being used to create a VPC with a specified CIDR block.

The custom ec2-instance module is used to create an EC2 instance in one of the private subnets created by the vpc module.

The subnet_id for the EC2 instance is dynamically set by referencing the subnet_ids output from the vpc module.

