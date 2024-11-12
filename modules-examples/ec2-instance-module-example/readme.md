# A simple module for ec2 instance.

```
ec2-instance-module-example/
├── main.tf            # Root module (calls the EC2 module)
├── ec2-instance/      # Module directory
│   ├── main.tf        # EC2 module definition
│   ├── variables.tf   # EC2 module variables
│   └── outputs.tf     # EC2 module outputs

```

Created a reusable module for launching an EC2 instance in AWS.

In this root configuration:

We are using the module block to call the EC2 instance module.

The source argument points to the directory where the EC2 module is defined (./ec2-instance).

We pass values for the variables defined in the module, thus overwriting the values which are already by default in the module. (like ami_id, instance_type, and instance_name).

The output instance_id will print the instance ID once the EC2 instance is created. 

