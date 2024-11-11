Basic Syntax of an Output Block

```
output "name_of_output" {
  value = <expression>
  description = "Optional description of the output"
  sensitive = <true|false>   # Optional: Hide sensitive data
}

```

name_of_output: 

The name of the output variable (a string).

value: 

This is the expression whose result we want to display. It can reference any resource or variable.

description (optional): 

A brief explanation of the output value, which helps us understand its purpose.

sensitive (optional): 

If true, this prevents the output from being displayed in plain text in the Terraform plan/apply output.

# Output EC2 Instance ID

aws_instance.ec2-test.id: 

This references the id attribute of the aws_instance resource named ec2-test.

value = aws_instance.ec2-test.id: 

The value of the output will be the instance ID of the created EC2 instance.
description: 

This is an optional field that describes what this output value represents (i.e., the instance ID).

# Output Multiple Values (IP Address & Instance ID)

We can output multiple values at once. For example, we may want to output both the instance ID and the public IP address of an EC2 instance.

# Using Sensitive Outputs

Sometimes, we may want to output sensitive data like passwords, API keys, or tokens, but we don’t want these values to be displayed in plaintext in the terminal. Terraform allows us to mark outputs as sensitive using the sensitive argument.

A random password is generated using the random_password resource, and the password is marked as sensitive.

To see the value of the sensitive output, we can use the terraform output command, but we'll need to use the -json flag to view it in a machine-readable format.