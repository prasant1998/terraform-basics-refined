Local values are variables defined within a Terraform configuration file that can store expressions or results of calculations. They allow us to simplify our configuration by storing intermediate values that will be used multiple times.

```
locals {
  <local_name> = <expression>
}
```

local_name: 
The name of the local value.

expression: 
The value that is computed and assigned to the local value. This can be any valid Terraform expression.

# Using Locals to Simplify Repeated Values

If we need to change the instance type later, we only need to change it in one place (the local definition), and it will automatically apply to all references.

# Using Locals with Complex Expressions

The local values local.environment and local.region are defined to store the environment ("dev") and region ("ap-northeast-2").

The local instance_name is created by combining environment and region into a single string using string interpolation. The result is "test-instance-dev-ap-northeast-2".

The instance_name is then used as the Name tag for the EC2 instance.

# Using Locals with Maps and Lists

Locals can store more complex data structures like maps and lists. We can also use locals to simplify the creation of resources based on multiple items.

The local.subnets map defines three subnets with corresponding CIDR blocks.

The for_each loop is used to iterate over each subnet in the map. The each.key gives the subnet name, and each.value gives the subnet CIDR block.

This allows us to create multiple subnets with minimal code, and the names and CIDR blocks are dynamically pulled from the map.

# Using Locals with Conditional Logic

We can also use locals with conditional logic to assign values based on conditions.

The local.instance_type is determined based on the value of the local.environment.

If the environment is "prod", the instance type will be "t3.medium". Otherwise, it will default to "t2.micro".

This allows us to easily switch between different configurations based on the environment.

# Using Locals to Calculate a List of Resources

If we need to create multiple resources based on a dynamic list, locals can help compute this list.

The local.instance_names list contains the names of the EC2 instances to create.

The for_each expression is used to iterate over the list and create an EC2 instance for each name in the list.

The each.key value corresponds to the instance name, and it is applied as the Name tag for each instance.

# Using Locals for Dynamic Values

Locals can also be used to handle complex logic or to generate dynamic values, such as creating a security group with multiple rules.

The local.common_ports and local.additional_ports lists define the common ports and additional ports, respectively.

The local.all_ports local is created by concatenating both lists using the concat function.

The dynamic block iterates over local.all_ports and generates an ingress rule for each port in the list.