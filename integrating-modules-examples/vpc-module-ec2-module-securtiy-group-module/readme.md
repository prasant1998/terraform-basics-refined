# Setting up both VPC from VPC module (sourced from terraregistry), EC2 from EC2 module (sourced from terraregistry) and Security Group (Sourced from Local).  Combined these modules to create a complete environment.


VPC Module (terraform-aws-modules/vpc/aws): 
This module will create a VPC, subnets, and associated network resources.

The module creates a VPC (192.168.0.0/16).
Two public subnets (192.168.101.0/24, 192.168.102.0/24), and two private subnets (192.168.201.0/24, 192.168.202.0/24) are created in different availability zones.


EC2 Instance Module (terraform-aws-modules/ec2-instance/aws): 
This module will create an EC2 instance within a specified subnet.

The EC2 instance is launched in one of the private subnets created by the VPC module.
We are specifying the AMI ID and instance type (t2.micro).
The security group is defined separately and passed as an ID to the vpc_security_group_ids argument.
The EC2 instance is associated with a private subnet (not a public IP) since it's within a private network.



Custom Security Group Module: 
We'll create a custom module to define a security group for the EC2 instance.

We define an AWS security group that allows inbound SSH and HTTPS (port 22, port 443) traffic from specific CIDR blocks (0.0.0.0/0 by default, but we can change it).
The security group is created in a specified VPC (vpc_id).
We define output sg_id to reference the security group's ID.