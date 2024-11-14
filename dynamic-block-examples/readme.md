dynamic blocks allow us to create multiple nested blocks dynamically based on a set of input data. It helps us avoid repetitive code, making our Terraform configurations more flexible. 

Dynamic blocks are particularly useful when the number of nested blocks is variable or depends on input parameters.

```
dynamic "block_name" {
  for_each = <expression>
  content {
    # Content of the block
  }
}


block_name: 
The name of the block we want to generate (for example, ingress, egress, server, etc.).

for_each: 
An expression (usually a list, map, or set) that defines how many instances of the block to create.

content: 
The content inside each block. This can reference the current item in the loop (each.value or each.key).

```

# Dynamic Security Group Ingress Rules

Managing security group rules for an AWS EC2 instance, 

We want to create multiple ingress rules dynamically. We have a variable that defines a list of IPs that should have access to the server on specific ports.

variable "ingress_rules" defines a list of objects with properties like cidr_block, from_port, to_port, and protocol.

The dynamic block is used to generate an ingress block for each item in var.ingress_rules.

ingress.value accesses the current item in the loop.

-----------------------------------------------------------------------------------------------

# Dynamic Ingress and Egress Rules for AWS Security Group

Created multiple ingress and egress rules dynamically using a map for different CIDR blocks, ports, and protocols.

Dynamic Ingress: 
Using a dynamic block for ingress to iterate over the list of ingress rules defined in the variable ingress_rules. The rule attributes (CIDR block, ports, and protocol) are dynamically created.

Dynamic Egress: 
Similarly, the dynamic block for egress iterates over egress_rules to generate egress rules dynamically.

This approach is useful when we want to create multiple rules without having to hardcode each one.