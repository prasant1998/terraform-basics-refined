# Using Outputs to Reference Resources Across Configurations

Outputs can also be used to pass information from one Terraform module to another. If we have multiple modules, we can use output values from one module as input to another.

The ec2_instance.tf module defines an EC2 instance and outputs its id.

The main configuration calls this module and uses the output value (module.compute.instance_id) as an output in the main configuration.